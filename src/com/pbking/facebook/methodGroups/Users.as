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
	import com.pbking.facebook.delegates.users.GetUserInfo_delegate;
	
	import flash.events.Event;
	
	public class Users
	{
		// VARIABLES //////////
		
		private var facebook:Facebook
		
		// CONSTRUCTION //////////
		
		function Users(facebook:Facebook):void
		{
			this.facebook = facebook;
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		public function getInfo(users:Array, fields:Array, callback:Function=null):GetUserInfo_delegate
		{
			var delegate:GetUserInfo_delegate = new GetUserInfo_delegate(facebook, users, fields);

			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);
			
			return delegate;
		}
		
		public function getLoggedInUser():void
		{
			//TODO: getLoggedInUser
		}
		
		public function hasAppPermission():void
		{
			//TODO: hasAppPermission
		}
		
		public function isAppAdded():void
		{
			//TODO: isAppAdded
		}
		
		public function setStatus():void
		{
			//TODO: setStatus
		}
		
	}
}