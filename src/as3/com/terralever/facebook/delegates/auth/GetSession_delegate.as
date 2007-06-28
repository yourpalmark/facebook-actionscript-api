/*
Copyright (c) 2007 Terralever

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

/**
 *  Delegates the call to facebook.auth.getSession
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.terralever.facebook.delegates.auth
{
	import com.terralever.facebook.FacebookCall;
	import com.terralever.facebook.Facebook;
	import flash.events.Event;
	import mx.logging.Log;
	import com.terralever.facebook.delegates.FacebookDelegate;
	
	public class GetSession_delegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		private var auth_token:String;
		
		//results
		
		public var session_key:String;
		public var uid:String;
		public var secret:String;
		public var expires:Number;
		
		// CONSTRUCTION //////////
		
		function GetSession_delegate(fBook:Facebook, auth_token:String)
		{
			super(fBook);
			this.auth_token = auth_token;

			Log.getLogger("terralever.facebook").debug("starting facebook session with auth_token: " + auth_token);

			var fbCall:FacebookCall = new FacebookCall(fBook);
			fbCall.setRequestArgument("auth_token", auth_token);
			fbCall.addEventListener(Event.COMPLETE, result);
			fbCall.post("facebook.auth.getSession", fBook.default_rest_url, true);
		}
		
		// FUNCTIONS //////////
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			session_key = fbCall.getResponse()..session_key;
			uid = fbCall.getResponse()..uid;
			secret = fbCall.getResponse()..secret;
			expires = fbCall.getResponse()..expires;
			
			onComplete();
		} 
		

	}
}