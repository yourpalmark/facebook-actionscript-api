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

/**
 *  Delegates the call to facebook.auth.getSession
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.delegates.auth
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class GetSessionDelegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		private var auth_token:String;
		
		//results
		
		public var session_key:String;
		public var uid:int;
		public var secret:String;
		public var expires:Number;
		
		// CONSTRUCTION //////////
		
		function GetSessionDelegate(facebook:Facebook, auth_token:String)
		{
			super(facebook);
			
			this.auth_token = auth_token;

			PBLogger.getLogger("pbking.facebook").debug("starting facebook session with auth_token: " + auth_token);

			fbCall.setRequestArgument("auth_token", auth_token);
			
			fbCall.post("facebook.auth.getSession", fBook.default_rest_url);
		}
		
		// FUNCTIONS //////////
		
		override protected function handleResult(result:Object):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			session_key = result.session_key;
			uid = result.uid;
			secret = result.secret;
			expires = result.expires;
		} 
		

	}
}