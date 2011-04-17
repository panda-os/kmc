package com.kaltura.vo
{
	import com.kaltura.vo.BaseFlexVo;
	import com.kaltura.vo.KalturaConversionProfileAssetParams;
	[Bindable]
	public dynamic class KalturaConversionProfileAssetParamsListResponse extends BaseFlexVo
	{
		/** 
		* 		* */ 
		public var objects : Array;

		/** 
		* 		* */ 
		public var totalCount : int = int.MIN_VALUE;

		/** 
		* a list of attributes which may be updated on this object 
		* */ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

		/** 
		* a list of attributes which may only be inserted when initializing this object 
		* */ 
		public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

	}
}
