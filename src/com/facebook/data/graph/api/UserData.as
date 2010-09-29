package com.facebook.data.graph.api
{
	public class UserData extends GraphData
	{
		public var first_name:String;
		public var last_name:String;
		public var link:String;
		public var about:String;
		public var birthday:Date;
		public var work:Array;
		public var education:Array;
		public var email:String;
		public var website:String;
		public var hometown:GraphData;
		public var location:GraphData;
		public var bio:String;
		public var quotes:String;
		public var gender:String;
		public var interested_in:String;
		public var meeting_for:String;
		public var relationship_status:String;
		public var religion:String;
		public var political:String;
		public var verified:Boolean;
		public var significant_other:GraphData;
		public var timezone:int;
		public var locale:String;
		public var updated_time:Date;
		
		public function UserData()
		{
			super();
		}
		
	}
}