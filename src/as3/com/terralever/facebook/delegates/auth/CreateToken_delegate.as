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
 *  Delegates the call to facebook.auth.createToken
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.terralever.facebook.delegates.auth
{
	import flash.events.Event;
	import com.terralever.facebook.FacebookCall;
	import com.terralever.facebook.Facebook;
	import com.terralever.facebook.delegates.FacebookDelegate;
	
	public class CreateToken_delegate extends FacebookDelegate
	{
		public var auth_token:String;
		
		function CreateToken_delegate(fBook:Facebook)
		{
			super(fBook);
			var fbCall:FacebookCall = new FacebookCall(fBook);
			fbCall.addEventListener(Event.COMPLETE, result);
			//ONLY the default REST url can be used here (redirection doesn't work)
			//we also have to make sure the sig is generated (which it doesn't if we're redirecting)
			fbCall.post("facebook.auth.createToken", fBook.default_rest_url, true);
		}
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			//there should be just a single value in the XML, the auth_token
			auth_token = fbCall.getResponse().toString();
			
			onComplete();
		}
	}
}