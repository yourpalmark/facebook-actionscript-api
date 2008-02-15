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
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.friends.AreFriendsDelegate;
	import com.pbking.facebook.delegates.friends.GetAppUsersDelegate;
	import com.pbking.facebook.delegates.friends.GetFriendsDelegate;
	
	public class Friends
	{
		// VARIABLES //////////
		
		private var facebook:Facebook;
		
		// CONSTRUCTION //////////
		
		function Friends(facebook:Facebook):void
		{
			this.facebook = facebook;
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		public function areFriends(list1:Array, list2:Array, callback:Function=null):AreFriendsDelegate
		{
			var delegate:AreFriendsDelegate = new AreFriendsDelegate(facebook, list1, list2);
			return MethodGroupUtil.addCallback(delegate, callback) as AreFriendsDelegate;		
		}
		
		public function areFriends2(user:FacebookUser, list:Array, callback:Function=null):AreFriendsDelegate
		{
			var newArray:Array = [];
			for each(var f:* in list)
				newArray.push(user);
				
			return areFriends(newArray, list, callback);
		}
		
		public function getFriends(callback:Function=null):GetFriendsDelegate
		{
			var delegate:GetFriendsDelegate = new GetFriendsDelegate(facebook);
			return MethodGroupUtil.addCallback(delegate, callback) as GetFriendsDelegate;		
		}
		
		public function getAppUsers(callback:Function=null):GetAppUsersDelegate
		{
			var delegate:GetAppUsersDelegate = new GetAppUsersDelegate(facebook);
			return MethodGroupUtil.addCallback(delegate, callback) as GetAppUsersDelegate;		
		}
	}
}