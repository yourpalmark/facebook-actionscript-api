package com.pbking.facebook.delegates.groups
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.groups.FacebookGroup;
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class GetGroupsDelegate extends FacebookDelegate
	{
		public var user:FacebookUser;
		public var groupsFilter:Array;
		
		public var groups:Array;
		
		public function GetGroupsDelegate(facebook:Facebook, user:FacebookUser=null, groupsFilter:Array=null)
		{
			super(facebook);
			
			this.user = user;
			this.groups = groups;
			
			if(user)
				fbCall.setRequestArgument("uid", user.uid.toString());
			
			if(groups && groups.length > 0)
			{
				var gids:Array;
				for each(var group:FacebookGroup in groups)
					gids.push(group.gid);
				fbCall.setRequestArgument("gids", gids.join(","));
			}
			
			fbCall.post("facebook.groups.get");
		}
		
		override protected function handleResult(result:Object):void
		{
			groups = [];
			
			for each(var groupX:Object in result)
			{
				var newGroup:FacebookGroup = FacebookGroup.getGroup(groupX.gid);
				groups.push(newGroup);
				
				if(groupX.name)
					newGroup.name = groupX.name;
				
				if(groupX.nid)
					newGroup.nid = groupX.nid;
				
				if(groupX.description)
					newGroup.description = groupX.description;
				
				if(groupX.group_type)
					newGroup.group_type = groupX.group_type;
				
				if(groupX.group_subtype)
					newGroup.group_subtype = groupX.group_subtype;
				
				if(groupX.recent_news)
				{
					newGroup.recent_news = [];
					for each(var rno:XML in groupX.recent_news.children)
					{
						newGroup.recent_news.push(rno);
					}
				}
				
				if(groupX.pic)
					newGroup.pic = groupX.pic;
				
				if(groupX.pic_big)
					newGroup.pic_big = groupX.pic_big;
				
				if(groupX.pic_small)
					newGroup.pic_small = groupX.pic_small;

				if(groupX.creator)
					newGroup.creator = FacebookUser.getUser(parseInt(groupX.creator));;
				
				if(groupX.update_time)
					newGroup.update_time = FacebookDataParser.formatDate(groupX.update_time);
				
				if(groupX.website)
					newGroup.website = groupX.website;

				if(groupX.office)
				{
					newGroup.office = new FacebookLocation();
					newGroup.office.street = groupX.office.street;
					newGroup.office.city = groupX.office.city;
					newGroup.office.state = groupX.office.state;
					newGroup.office.country = groupX.office.country;
					newGroup.office.zip = groupX.office.zip;
				}

				if(groupX.venue)
				{
					newGroup.venue = new FacebookLocation();
					newGroup.venue.street = groupX.venue.street;
					newGroup.venue.city = groupX.venue.city;
					newGroup.venue.state = groupX.venue.state;
					newGroup.venue.country = groupX.venue.country;
					newGroup.venue.zip = groupX.venue.zip;
				}

			}
			
		}
		
	}
}