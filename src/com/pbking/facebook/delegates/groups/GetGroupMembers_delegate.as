package com.pbking.facebook.delegates.groups
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.groups.FacebookGroup;
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetGroupMembers_delegate extends FacebookDelegate
	{
		public var group:FacebookGroup;
		
		public function GetGroupMembers_delegate(group:FacebookGroup)
		{
			this.group = group;
			
			fbCall.setRequestArgument("gid", group.gid.toString());
			fbCall.post("facebook.groups.getMembers");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			super.handleResult(resultXML);
			
			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			var uid:XML;

			group.members.removeAll();
			for each(uid in resultXML.members.children())
				group.members.addUser(fBook.getUser(parseInt(uid)));
			
			group.admins.removeAll();
			for each(uid in resultXML.admins.children())
				group.admins.addUser(fBook.getUser(parseInt(uid)));
			
			group.officers.removeAll();
			for each(uid in resultXML.officers.children())
				group.officers.addUser(fBook.getUser(parseInt(uid)));
			
			group.not_replied.removeAll();
			for each(uid in resultXML.not_replied.children())
				group.not_replied.addUser(fBook.getUser(parseInt(uid)));
			
		}
		
	}
}