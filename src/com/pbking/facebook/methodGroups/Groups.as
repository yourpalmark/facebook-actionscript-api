/*
Copyright (c) 2007 Jason Crist

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

package com.pbking.facebook.methodGroups
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.groups.FacebookGroup;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.groups.GetGroupMembersDelegate;
	import com.pbking.facebook.delegates.groups.GetGroupsDelegate;
	
	public class Groups
	{
		// VARIABLES //////////
		
		private var facebook:Facebook;
		
		// CONSTRUCTION //////////
		
		function Groups(facebook:Facebook):void
		{
			this.facebook = facebook;
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		/**
		 * Returns all visible groups according to the filters specified. 
		 * You can use this method to return all groups associated with a user, 
		 * or query a specific set of groups by a list of GIDs.
		 * If both the uid and gids parameters are provided, the method returns all 
		 * groups in the set of gids with which the user is associated. If the gids 
		 * parameter is omitted, the method returns all groups associated with the 
		 * provided user.
		 * However, if the uid parameter is omitted, the method returns all groups 
		 * associated with the provided gids, regardless of any user relationship.
		 * If both parameters are omitted, the method returns all groups of the session user. 
		 */
		public function getGroups(user:FacebookUser=null, groupsFilter:Array=null, callback:Function=null):GetGroupsDelegate
		{
			var d:GetGroupsDelegate = new GetGroupsDelegate(facebook, user, groupsFilter);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		public function getMembers(group:FacebookGroup, callback:Function=null):GetGroupMembersDelegate
		{
			var d:GetGroupMembersDelegate = new GetGroupMembersDelegate(facebook, group);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

	}
}