package com.facebook.data.graph.api
{
	public class EducationData extends GraphData
	{
		public var school:GraphData;
		public var year:GraphData;
		public var concentration:Array;
		public var type:String;
		
		public function EducationData()
		{
			super();
		}
		
	}
}