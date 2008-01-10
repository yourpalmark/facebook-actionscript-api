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
	import com.pbking.facebook.data.events.FacebookEvent;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.events.GetEventMembers_delegate;
	import com.pbking.facebook.delegates.events.GetEvents_delegate;
	
	public class Events
	{
		// CONSTRUCTION //////////
		
		function Events():void
		{
			//nothing here
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		/**
		 * Returns all visible events according to the filters specified. 
		 * You can use this method to find all events for a user, or to query a 
		 * specific set of events by a list of event IDs (eids).
		 * 
		 * If both the uid and eids parameters are provided, the method returns all 
		 * events in the set of eids that are associated with the user. If no eids 
		 * parameter are specified, the method returns all events associated with the 
		 * specified user.
		 * 
		 * If the uid parameter is omitted, the method returns all events associated 
		 * with the provided eids, regardless of any user relationship.
		 * 
		 * If both parameters are omitted, the method returns all events associated with 
		 * the session user.
		 * 
		 * start_time and end_time parameters specify a (possibly open-ended) window in 
		 * which all events returned overlap. Note that if start_time is greater than or 
		 * equal to end_time, an empty top-level element is returned. 
		 */
		public function getEvents(user:FacebookUser=null, eventsFilter:Array=null, start_time:Date=null, end_time:Date=null, rsvp_status_filter:String="", callback:Function=null):GetEvents_delegate
		{
			var d:GetEvents_delegate = new GetEvents_delegate(user, eventsFilter, start_time, end_time, rsvp_status_filter);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}
		
		public function getEventMembers(event:FacebookEvent, callback:Function=null):GetEventMembers_delegate
		{
			var d:GetEventMembers_delegate = new GetEventMembers_delegate(event);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}
	}
}