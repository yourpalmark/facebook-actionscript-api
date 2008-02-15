package com.pbking.facebook.data.groups
{
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.users.FacebookUserCollection;
	import com.pbking.util.collection.HashableArray;
	
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
			if(_locked)
				throw new Error("a group should be created by calling FacebookGroup.getGroup(gid) so that there is only ever a single instance of each group");

			this.gid = gid;
		}
		
		/**
		 * This keeps a common collection of groups so that all information gathered
		 * on groups is stored here and updated.  Each group should have only one instance.
		 * 
		 * Creating a group should happen from this method.
		 */
		public static function getGroup(gid:Number):FacebookGroup
		{
			var group:FacebookGroup = _groupCollection.getItemById(gid) as FacebookGroup;
			if(!group)
			{
				_locked = false;
				group = new FacebookGroup(gid);
				_locked = true;
				_groupCollection.addItem(group);
			}
			return group;
		}
		
		private static var _groupCollection:HashableArray = new HashableArray('gid', false);
		private static var _locked:Boolean = true;
		
	}
}