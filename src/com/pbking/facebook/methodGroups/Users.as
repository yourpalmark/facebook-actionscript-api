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
		
		private var facebook:Facebook;
		
		// CONSTRUCTION //////////
		
		function Users(facebook:Facebook):void
		{
			this.facebook = facebook;
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		/**
		 * Returns a wide array of user-specific information for each user identifier passed, limited by the view of the current user. The current user is determined from the session_key parameter. The only storable values returned from this call are the those under the affiliations element, the notes_count value, and the contents of the profile_update_time element.
		 */
		public function getInfo(users:Array, fields:Array, callback:Function=null):GetUserInfoDelegate
		{
			var delegate:GetUserInfoDelegate = new GetUserInfoDelegate(facebook, users, fields);
			return MethodGroupUtil.addCallback(delegate, callback) as GetUserInfoDelegate;
		}
		
		/**
		 * Gets the user id (uid) associated with the current session. This value should be stored for the duration of the session, to avoid unnecessary subsequent calls to this method.
		 */
		public function getLoggedInUser(callback:Function=null):GetLoggedInUserDelegate
		{
			var delegate:GetLoggedInUserDelegate = new GetLoggedInUserDelegate(facebook);
			return MethodGroupUtil.addCallback(delegate, callback) as GetLoggedInUserDelegate;
		}
		
		/**
		 * Checks whether the user has opted in to an extended application permission.
		 * See: http://wiki.developers.facebook.com/index.php/Extended_application_permission for more info.
		 * 
		 * @param extendedPermission:String String identifier for the extended permission that is being checked for. 
		 * Must be one of status_update, create_listing, or photo_upload.
		 */
		public function hasAppPermission(extendedPermission:String, callback:Function=null):HasAppPermissionDelegate
		{
			var delegate:HasAppPermissionDelegate = new HasAppPermissionDelegate(facebook, extendedPermission);
			return MethodGroupUtil.addCallback(delegate, callback) as HasAppPermissionDelegate;
		}
		
		/**
		 * Returns whether the logged-in user has added the calling application.
		 */
		public function isAppAdded(callback:Function=null):IsAppAddedDelegate
		{
			var delegate:IsAppAddedDelegate = new IsAppAddedDelegate(facebook);
			return MethodGroupUtil.addCallback(delegate, callback) as IsAppAddedDelegate;
		}
		
		/**
		 * Updates a user's Facebook status. This method requires the extended permission status_update, 
		 * which the user must opt into via the Extended Permissions system. 
		 */
		public function setStatus(status:String, clear:Boolean=false, callback:Function=null):SetStatusDelegate
		{
			var delegate:SetStatusDelegate = new SetStatusDelegate(facebook, status, clear);
			return MethodGroupUtil.addCallback(delegate, callback) as SetStatusDelegate;
		}
		
	}
}