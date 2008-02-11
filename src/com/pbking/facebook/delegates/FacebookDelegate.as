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
 *  Base class for all Facebook Delegates
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	//dispatched when the delegate has completed the transaction
	[Event(name="complete", type="flash.events.Event")]
	
	public class FacebookDelegate extends EventDispatcher
	{
		protected var fBook:Facebook;
		protected var fbCall:FacebookCall;
		
		public var success:Boolean = false;
		public var errorCode:int = 0;
		public var errorMessage:String = "";
		
		function FacebookDelegate()
		{
			this.fBook = Facebook.instance;
			fbCall = new FacebookCall(fBook);
			fbCall.addEventListener(Event.COMPLETE, result);
			fbCall.addEventListener(IOErrorEvent.IO_ERROR, onCallError);
			fbCall.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCallError);
		}
		
		public function getResponseXML():XML
		{
			return fbCall.getResponse();
		}
		
		protected function onCallError(event:ErrorEvent):void
		{
			//something super sucky happened
			errorCode = -1;
			errorMessage = event.toString();
			onError();
		}
		
		protected function result(event:Event):void
		{
			fbCall.removeEventListener(Event.COMPLETE, result);

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			//look for an error
			if(fbCall.getResponse().error_code != undefined)
			{
				//dang.  handle the error
				this.errorCode = fbCall.getResponse().error_code;
				this.errorMessage = fbCall.getResponse().error_msg;
				onError();
			}
			else
			{
				//send the results to the children
				handleResult(fbCall.getResponse());
				onComplete();
			}
		}
		
		protected function handleResult(resultXML:XML):void
		{
			//Children should override this methid
		}
		
		protected function onComplete():void
		{
			this.success = true;
			dispatchEvent(new Event(Event.COMPLETE));
		}

		protected function onError():void
		{
			this.success = false;
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}