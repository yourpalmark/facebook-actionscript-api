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
 * Makes the call to the Facebook REST service  
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook
{
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.EventDispatcher;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	
	[Event(name="complete", type="flash.events.Event")]
	
	[Bindable]
	public class FacebookCall extends EventDispatcher
	{
		// VARIABLES //////////
		
		protected static var callID:uint = 0;
		
		protected var logger:PBLogger = PBLogger.getLogger("pbking.facebook");
		
		protected var repressOnComplete:Boolean = false;
		
		public var args:URLVariables;
		public var method:String;
		
		public var result:Object;
		public var exception:Object;

		public var success:Boolean = false;
		public var errorCode:int = 0;
		public var errorMessage:String = "";

		public var facebook:Facebook;
		
		public var callbacks:Dictionary = new Dictionary(true);
		
		// CONSTRUCTION //////////
		
		function FacebookCall(method:String="no_method_required", args:URLVariables=null)
		{
			this.method = method;
			this.args = args ? args : new URLVariables();
		}
		
		// PUBLIC METHODS //////////
		
		/**
		 * Similar to a dispatched event this will call a method when a call is complete
		 * (either successful or not).  Instead of an Event instance being passed to
		 * the function, however, this instance of the call is passed. A weak-keyed
		 * dictionary is used to keep track of the callbacks so that reference to objects
		 * shouldn't "hang around" after they are no longer needed.
		 * 
		 * @param callback Function the function to call when the call is complete.  
		 * The function will be passed this instance of FacebookCall.
		 */
		public function addCallback(callback:Function):void
		{
			callbacks[callback] = callback;
		}

		/**
		 * Set a name value pair to be sent in request postdata.  
		 * You could of course set these directly on the args variable 
		 * but this method proves handy too.
		 * 
		 * @param name String the name of the argument
		 * @param value * the value of the argument
		 */
		public function setRequestArgument( name:String, value:* ):void
		{
			this.args[name] = value;	
		}
		
		/**
		 * Clear the values out the the .args object.  Sometiles useful
		 * in the initialize() method.
		 */
		public function clearRequestArguments():void
		{
			this.args = new URLVariables();
		}
		
		/** 
		 * Initialize the facebook call.
		 * This will normally be used to convert class variables into arg values.
		 * Because a call can be used over and over if desired this method will
		 * be called so that child classes can re-initialize the .arg values.
		 */
		public function initialize():void
		{
			//override in case something needs to be initialized prior to execution
		}
		
		/**
		 * Execute a call.  A Facebook value MUST be provided either as a param 
		 * or set as the public class variable.
		 * To execute a call you can either pass the call to a facebook instance
		 * [facebookInstance.post(callInstance); ] or call this method which will 
		 * pass the call to the facebook for you.  This method will mostly be used
		 * when the call is constructed as an MXML object.
		 * 
		 * @param facebook Facebook optional facebook instance that the call will
		 * be executed with.  If this paramater is not set the public .facebook
		 * property MUST be set or an error will be thrown.
		 */
		public function execute(facebook:Facebook=null):IFacebookCallDelegate
		{
			if(facebook)
				return facebook.post(this);
				
			else if(this.facebook)
				return this.facebook.post(this);

			throw new Error("No Facebook value defined for FacebookCall to execute with");
			return null;
		}
		
		/**
		 * Called from the IFacebookCallDelegate when the communication 
		 * has been completed. This method will determine the success, 
		 * parse out any errors, call the handleSuccess method on successful
		 * calls (so that extended classes can easily handle the success of
		 * the call) and inform any listeners/callbacks that the call is
		 * complete.
		 * 
		 * @param result Object the result object provided from the Facebook 
		 * REST services
		 *
 		 * @param exception Object the exception object provided from the Facebook 
		 * REST services
		 */
		public function handleResult(result:Object, exception:Object):void
		{
			this.result = result;
			this.exception = exception;
			
			//look for an error
			if(result && result.hasOwnProperty('error_code'))
			{
				//dang.  handle the error
				this.errorCode = result.error_code;
				this.errorMessage = result.error_msg;
				this.success = false;

				//pass it on in case a child wants to do something with it
				handleException(exception);
				
				logger.debug('error making call: ' + errorCode +"|"+errorMessage);
			}
			else
			{
				this.success = true;
				handleSuccess(result);
			}

			if(!repressOnComplete)
				onComplete();
		}
		
		/**
		 * Handles the event dispatching and callbacks for when a call has been completed.
		 * This is NORMALLY called at the end of handleResult, however it's possible for
		 * an extended class to set the respressOnComplete value to TRUE so that this 
		 * doesn't happen.  In that case the child class would then need to call the 
		 * onComplete method itself.  GetAlbums is an example of this.
		 */
		protected function onComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
			
			for each(var f:Function in callbacks)
				f(this);
		}
		
		/**
		 * A utility method used by extended classes.  The result is
		 * passed to this method from the handleResult method.
		 * This method should NOT be called directly.
		 */
		protected function handleSuccess(result:Object):void
		{
			//override this
		}

		/**
		 * A utility method used by extended classes.  The exception is
		 * passed to this method from the handleResult method.
		 * This method should NOT be called directly.
		 */
		protected function handleException(exception:Object):void
		{
			//override this
		}

	}
}