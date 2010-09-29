package com.facebook.data.graph.api
{
	public class WorkData extends GraphData
	{
		public var employer:GraphData;
		public var location:GraphData;
		public var position:GraphData;
		public var description:String;
		public var start_date:Date;
		public var end_date:Date;
		
		public function WorkData()
		{
			super();
		}
		
	}
}