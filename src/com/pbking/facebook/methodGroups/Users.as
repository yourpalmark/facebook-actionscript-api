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
	import com.pbking.facebook.delegates.users.*;
	
	import flash.events.Event;
	
	public class Users
	{
		// VARIABLES //////////
		
		// CONSTRUCTION //////////
		
		function Users():void
		{
			//nothing here
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		/**
		 * Returns a wide array of user-specific information for each user identifier passed, limited by the view of the current user. The current user is determined from the session_key parameter. The only storable values returned from this call are the those under the affiliations element, the notes_count value, and the contents of the profile_update_time element.
		 */
		public function getInfo(users:Array, fields:Array, callback:Function=null):GetUserInfo_delegate
		{
			var delegate:GetUserInfo_delegate = new GetUserInfo_delegate(users, fields);
			return MethodGroupUtil.addCallback(delegate, callback) as GetUserInfo_delegate;
		}
		
		/**
		 * Gets the user id (uid) associated with the current session. This value should be stored for the duration of the session, to avoid unnecessary subsequent calls to this method.
		 */
		public function getLoggedInUser(callback:Function=null):GetLoggedInUser_delegate
		{
			var delegate:GetLoggedInUser_delegate = new GetLoggedInUser_delegate();
			return MethodGroupUtil.addCallback(delegate, callback) as GetLoggedInUser_delegate;
		}
		
		/**
		 * Checks whether the user has opted in to an extended application permission.
		 * See: http://wiki.developers.facebook.com/index.php/Extended_application_permission for more info.
		 * 
		 * @param extendedPermission:String String identifier for the extended permission that is being checked for. 
		 * Must be one of status_update, create_listing, or photo_upload.
		 */
		public function hasAppPermission(extendedPermission:String, callback:Function=null):HasAppPermission_delegate
		{
			var delegate:HasAppPermission_delegate = new HasAppPermission_delegate(extendedPermission);
			return MethodGroupUtil.addCallback(delegate, callback) as HasAppPermission_delegate;
		}
		
		/**
		 * Returns whether the logged-in user has added the calling application.
		 */
		public function isAppAdded(callback:Function=null):IsAppAdded_delegate
		{
			var delegate:IsAppAdded_delegate = new IsAppAdded_delegate();
			return MethodGroupUtil.addCallback(delegate, callback) as IsAppAdded_delegate;
		}
		
		/**
		 * Updates a user's Facebook status. This method requires the extended permission status_update, which the user must opt into via the Extended Permissions system. 
		 */
		public function setStatus(status:String, clear:Boolean=false, callback:Function=null):SetStatus_delegate
		{
			var delegate:SetStatus_delegate = new SetStatus_delegate(status, clear);
			return MethodGroupUtil.addCallback(delegate, callback) as SetStatus_delegate;
		}
		
	}
}