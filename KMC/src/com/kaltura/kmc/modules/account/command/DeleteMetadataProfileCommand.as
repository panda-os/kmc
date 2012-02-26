package com.kaltura.kmc.modules.account.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.MultiRequest;
	import com.kaltura.commands.metadataProfile.MetadataProfileDelete;
	import com.kaltura.commands.metadataProfile.MetadataProfileList;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.business.JSGate;
	import com.kaltura.kmc.modules.account.events.MetadataProfileEvent;
	import com.kaltura.kmc.modules.account.model.AccountModelLocator;
	import com.kaltura.kmc.utils.ListMetadataProfileUtil;
	import com.kaltura.types.KalturaMetadataObjectType;
	import com.kaltura.types.KalturaMetadataOrderBy;
	import com.kaltura.utils.parsers.MetadataProfileParser;
	import com.kaltura.vo.KMCMetadataProfileVO;
	import com.kaltura.vo.KalturaMetadataProfile;
	import com.kaltura.vo.KalturaMetadataProfileFilter;
	import com.kaltura.vo.KalturaMetadataProfileListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	/**
	 * This class handles the deletion of a custom data schema
	 * @author Michal
	 * 
	 */	
	public class DeleteMetadataProfileCommand implements ICommand, IResponder {
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		/**
		 * Will send a MetadataProfileDelete request. 
		 * @param event the event that triggered this command.
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			_model.loadingFlag  = true;
			var schemasToDelete:Array = (event as MetadataProfileEvent).profilesArray;
			if (!schemasToDelete || schemasToDelete.length==0)
				return;
			
			var mr:MultiRequest = new MultiRequest();
			
			for each (var profile:KMCMetadataProfileVO in schemasToDelete) {
				var deleteSchema:MetadataProfileDelete = new MetadataProfileDelete(profile.profile.id);
				mr.addAction(deleteSchema);
			}
			//list the latest metadata profiles (after all deletion is done)s
			var filter:KalturaMetadataProfileFilter = new KalturaMetadataProfileFilter();
			filter.orderBy = KalturaMetadataOrderBy.CREATED_AT_DESC;
			filter.metadataObjectTypeEqual = KalturaMetadataObjectType.ENTRY;
//			filter.metadataObjectTypeIn = KalturaMetadataObjectType.ENTRY + "," + KalturaMetadataObjectType.CATEGORY;			
			var listMetadataProfile:MetadataProfileList = new MetadataProfileList(filter, _model.metadataFilterPager);
			mr.addAction(listMetadataProfile);
			
			mr.addEventListener(KalturaEvent.COMPLETE, result);
			mr.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(mr);
		}
		
		/**
		 * Will be called when the result from the server returns 
		 * @param data the data recieved from the server
		 * 
		 */		
		public function result(data:Object):void
		{
			_model.loadingFlag = false;
			var responseArray:Array = data.data as Array;
			//last request is always the list request
			var listResult:KalturaMetadataProfileListResponse  = responseArray[responseArray.length-1]as KalturaMetadataProfileListResponse;
			_model.metadataProfilesTotalCount = listResult.totalCount;
			_model.metadataProfilesArray = ListMetadataProfileUtil.handleListMetadataResult(listResult, _model.context);
		}
		
		/**
		 * Will be called when the request fails 
		 * @param info the info from the server
		 * 
		 */	
		public function fault(info:Object):void
		{
			if(info && info.error && info.error.errorMsg && info.error.errorMsg.toString().indexOf("Invalid KS") > -1 )
			{
				JSGate.expired();
				return;
			}
			_model.loadingFlag = false;
			Alert.show(info.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			
		}
		
	}
}