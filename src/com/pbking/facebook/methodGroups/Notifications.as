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
	import com.pbking.facebook.delegates.notifications.GetNotifications_delegate;
	import com.pbking.facebook.delegates.notifications.SendNotification_delegate;
	
	public class Notifications
	{
		// VARIABLES //////////
		
		// CONSTRUCTION //////////
		
		function Notifications():void
		{
			//nothing here
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		/**
		 * Returns information on outstanding Facebook notifications for current session user.
		 */
		public function getNotifications(callback:Function=null):GetNotifications_delegate
		{
			var delegate:GetNotifications_delegate = new GetNotifications_delegate();
			return MethodGroupUtil.addCallback(delegate, callback) as GetNotifications_delegate;
		}

		/**
		 * Send a notification to a set of users. You can also send messages to the logged-in 
		 * user's notification page. Your application can send up to 40 notifications to the 
		 * notifications page per user per day. Notifications sent to the notifications page 
		 * for non-application users are subject to spam control. Read more information about 
		 * how spamminess is measured. Additionally, any notification that you send on behalf 
		 * of a user appears on that user's notifications page as a "sent notification."
		 * 
		 * @param notification:String FBML for the notifications page. Uses a stripped down 
		 * version allowing only text and links.
		 * 
		 * @param users:Array Array of users. These must be either friends of the logged-in user 
		 * or people who have added your application. To send a notification to the current 
		 * logged-in user without a name prepended to the message, set users to null.
		 */
		public function send(notification:String, users:Array=null, callback:Function=null):SendNotification_delegate
		{
			var delegate:SendNotification_delegate = new SendNotification_delegate(notification, users);
			return MethodGroupUtil.addCallback(delegate, callback) as SendNotification_delegate;
		}

	}
}