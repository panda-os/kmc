package com.kaltura.edw.model
{
	import com.kaltura.dataStructures.HashMap;
	import com.kaltura.edw.vo.CategoryVO;
	import com.kaltura.vo.KMCMetadataProfileVO;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * data that is needed for all filter instances 
	 * @author Atar
	 */	
	public class FilterModel {
		
		
		/**
		 * this partner is allowed to see metadata related stuff.
		 * value is set via roles and permissions
		 * */
		public var enableCustomData:Boolean = true;
		
		/**
		 * the root of a category hierarchy. 
		 * */
		public var categories:CategoryVO = null;
		
		/**
		 * categories listing
		 * */
		public var categoriesMap:HashMap = new HashMap();
		
		/**
		 * list of <code>KalturaFlavorParams</code>
		 * */
		public var flavorParams:ArrayCollection = new ArrayCollection();

		/**
		 * list of KMCMetadataProfileVO
		 * */
		public var metadataProfiles:ArrayCollection;
		/**
		 * list of FormBuilder, the indices should suit the metadataProfiles arrayCollection
		 * */
		public var formBuilders:ArrayCollection;
		
		/**
		 * a list of access control profiles of the current partner,
		 * <Code>AccessControlProfileVO</code> objects 
		 */		
		public var accessControlProfiles:ArrayCollection = new ArrayCollection();
		
		/**
		 * load access control only once 
		 */		
		public var oneTimeLoadAccessControlLoadedFlag:Boolean = false;
		
		/**
		 * indicates if we have the distribution plugin
		 * */
		public var enableDistribution:Boolean = true;
		
		/**
		 * indicates if re-loading of filter data is required
		 * */
		public var loadingRequired:Boolean = true;

	}
}