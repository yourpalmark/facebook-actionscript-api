package com.pbking.facebook.data.users
{
	import com.pbking.facebook.data.misc.FacebookLocation;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class FacebookUser extends EventDispatcher
	{
		public var uid:Number;
		
		public var isLoggedInUser:Boolean;
		
		public var name:String = "";
		public var first_name:String = "";
		public var last_name:String = "";
		
		public var pic:String;
		public var pic_big:String;
		public var pic_small:String;
		public var pic_square:String;

		public var sex:String;
		public var birthday:Date;
		public var about_me:String;
		public var activities:String;
		public var affiliations:Array;
		public var books:String;
		public var interests:String;
		public var movies:String;
		public var music:String;
		public var political:String;
		public var quotes:String;
		public var religion:String
		public var tv:String;

		public var networkAffiliations:Array;

		public var education_history:Array;

		public var timezone:int;
		public var current_location:FacebookLocation;
		public var hometown_location:FacebookLocation;

		public var hs1_name:String;
		public var hs2_name:String;
		public var grad_year:String;
		public var hs1_id:int;
		public var hs2_id:int;
		
		public var is_app_user:Boolean;
		public var has_added_app:Boolean;
		
		public var meeting_for:Array;
		public var meeting_sex:Array;
		
		public var relationship_status:String;
		public var significant_other_id:int;

		public var profile_update_time:Date;
		public var status_message:String;
		public var status_time:Date;

		public var notes_count:int;
		public var wall_count:int;
		
		public var work_history:Array;

		public var friends:Array;

 		function FacebookUser(uid:int):void
		{
			this.uid = uid;
			
			//just making sure the UserFields is imported
			UserFields;
		}
	}
}