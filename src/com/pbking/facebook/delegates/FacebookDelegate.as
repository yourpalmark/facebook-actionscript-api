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
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.Facebook;
	import flash.events.ErrorEvent;

	//dispatched when the delegate has completed the transaction
	[Event(name="complete", type="flash.events.Event")]
	
	//dispatched when the delegate has an error
	[Event(name="error", type="flash.events.ErrorEvent")]

	public class FacebookDelegate extends EventDispatcher
	{
		protected var fBook:Facebook;
		
		function FacebookDelegate(fBook:Facebook)
		{
			this.fBook = fBook;
		}
		
		protected function result(event:Event):void
		{
			//this method should be overridden
		}
		
		protected function onComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}

		protected function onError():void
		{
			dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
		}
	}
}