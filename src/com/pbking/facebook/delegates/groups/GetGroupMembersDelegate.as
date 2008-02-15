package com.pbking.facebook.delegates.groups
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.groups.FacebookGroup;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetGroupMembersDelegate extends FacebookDelegate
	{
		public var group:FacebookGroup;
		
		public function GetGroupMembersDelegate(facebook:Facebook, group:FacebookGroup)
		{
			super(facebook);
			
			this.group = group;
			
			fbCall.setRequestArgument("gid", group.gid.toString());
			fbCall.post("facebook.groups.getMembers");
		}
		
		override protected function handleResult(result:Object):void
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