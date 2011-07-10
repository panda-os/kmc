package com.kaltura.kmc.modules.content.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class CuePointEvent extends CairngormEvent {
		
		/**
		 * count the cuepoints for a given entry.
		 * event.data should be entryid. 
		 */		
		public static const COUNT_CUEPOINTS:String = "count_cuepoints";
		
		/**
		 * download cuepoints to file.
		 * event.data should be entryid. 
		 * */
		public static const DOWNLOAD_CUEPOINTS:String = "download_cuepoints";
		
		/**
		 * upload cuepoints from file.
		 * event.data should be entryid. 
		 * */ 
		public static const UPLOAD_CUEPOINTS:String = "upload_cuepoints";
		
		
		public function CuePointEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
	}
}