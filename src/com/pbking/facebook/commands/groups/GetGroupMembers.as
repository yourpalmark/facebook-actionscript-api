package com.pbking.facebook.delegates.groups
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.groups.FacebookGroup;
	import com.pbking.facebook.data.users.FacebookUser;

	public class GetGroupMembers extends FacebookCall
	{
		public var group:FacebookGroup;
		
		public function GetGroupMembers(group:FacebookGroup)
		{
			super("facebook.groups.getMembers");
			
			this.group = group;
		}
		
		override public function initialize():void
		{
			setRequestArgument("gid", group.gid);
		}
		
		override protected function handleSuccess(result:Object):void
		{
			var uid:int;

			group.members.removeAll();
			for each(uid in result.members)
				group.members.addUser(FacebookUser.getUser(uid));
			
			group.admins.removeAll();
			for each(uid in result.admins)
				group.admins.addUser(FacebookUser.getUser(uid));
			
			group.officers.removeAll();
			for each(uid in result.officers)
				group.officers.addUser(FacebookUser.getUser(uid));
			
			group.not_replied.removeAll();
			for each(uid in result.not_replied)
				group.not_replied.addUser(FacebookUser.getUser(uid));
			
		}
		
	}
}