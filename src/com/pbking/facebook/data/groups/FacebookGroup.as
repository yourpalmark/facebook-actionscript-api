package com.pbking.facebook.data.groups
{
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.users.FacebookUserCollection;
	
	[Bindable]
	public class FacebookGroup
	{
		public var gid:Number;
		public var nid:Number;

		public var name:String;
		public var description:String;

		public var group_type:String;
		public var group_subtype:String;

		public var recent_news:Array;

		public var pic:String;
		public var pic_big:String;
		public var pic_small:String;

		public var creator:FacebookUser;
		public var update_time:Date;
		public var office:FacebookLocation;
		public var website:String;
		public var venue:FacebookLocation;
		
		public var members:FacebookUserCollection = new FacebookUserCollection();
		public var admins:FacebookUserCollection = new FacebookUserCollection();
		public var officers:FacebookUserCollection = new FacebookUserCollection();
		public var not_replied:FacebookUserCollection = new FacebookUserCollection();
		
		function FacebookGroup(gid:Number)
		{
			this.gid = gid;
		}
	}
}