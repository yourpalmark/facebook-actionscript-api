/**
 *  Base class for all Facebook Delegates
 * 
 * @author Jason Crist 
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
		// VARIABLES //////////
		
		protected var fBook:Facebook;
		protected var fbCall:FacebookCall;
		
		public var success:Boolean = false;
		public var errorCode:int = 0;
		public var errorMessage:String = "";
		
		// CONSTRUCTION //////////
		
		function FacebookDelegate(facebook:Facebook)
		{
			this.fBook = facebook;
			fbCall = new FacebookCall(fBook);
			fbCall.addEventListener(Event.COMPLETE, onCallComplete);
			fbCall.addEventListener(IOErrorEvent.IO_ERROR, onCallError);
			fbCall.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCallError);
		}
		
		//////////
		
		private function removeFBCallListeners():void
		{
			if(!fbCall) return;
				
			fbCall.removeEventListener(Event.COMPLETE, onCallComplete);
			fbCall.removeEventListener(IOErrorEvent.IO_ERROR, onCallError);
			fbCall.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onCallError);
		}
		
		public function get result():Object
		{
			return fbCall.result;
		}
		
		protected function onCallError(event:ErrorEvent):void
		{
			removeFBCallListeners();
			//something super sucky happened
			errorCode = -1;
			errorMessage = event.toString();
			onError();
		}
		
		protected function onCallComplete(event:Event):void
		{
			removeFBCallListeners();
			
			var result:Object = fbCall.result;

			//look for an error
			if(result && result.hasOwnProperty('error_code'))
			{
				//dang.  handle the error
				this.errorCode = result.error_code;
				this.errorMessage = result.error_msg;
				onError();
			}
			else
			{
				//send the results to the children
				handleResult(result);
				onComplete();
			}
		}
		
		protected function handleResult(result:Object):void
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