/**
 * Makes the call to the Facebook REST service.
 * 
 */
package com.facebook.net {
	
	import com.facebook.data.FacebookData;
	import com.facebook.delegates.IFacebookCallDelegate;
	import com.facebook.errors.FacebookError;
	import com.facebook.events.FacebookEvent;
	import com.facebook.facebook_internal;
	import com.facebook.session.IFacebookSession;
	
	import flash.events.EventDispatcher;
	import flash.net.URLVariables;
	
	use namespace facebook_internal;
	
	public class FacebookCall extends EventDispatcher {
		
		public var args:URLVariables;
		public var method:String;
		
		public var result:FacebookData;
		public var error:FacebookError;
		public var delegate:IFacebookCallDelegate;
		public var session:IFacebookSession;
		public var success:Boolean = false;
		
		public function FacebookCall(method:String="no_method_required", args:URLVariables=null) {
			this.method = method;
			this.args = args != null ? args : new URLVariables();
		}
		
		/**
		 * Set a name value pair to be sent in request postdata.  
		 * You could of course set these directly on the args variable 
		 * but this method proves handy too.
		 * 
		 * @param name String the name of the argument
		 * @param value * the value of the argument
		 */
		facebook_internal function setRequestArgument(name:String, value:Object):void {
			if (value is Number && isNaN(value as Number)) { return; }
			
			if (name && value != null && String(value).length > 0) {
				this.args[name] = value;
			}
		}
		
		/**
		 * Clear the values out the the .args object.  Sometiles useful
		 * in the initialize() method.
		 */
		facebook_internal function clearRequestArguments():void {
			this.args = new URLVariables();
		}
		
		/** 
		 * Initialize the facebook call.
		 * This will normally be used to convert class variables into arg values.
		 * Because a call can be used over and over if desired this method will
		 * be called so that child classes can re-initialize the .arg values.
		 */
		facebook_internal function initialize():void {
			//override in case something needs to be initialized prior to execution
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
		 */
		facebook_internal function handleResult(result:FacebookData):void {
			this.result = result;
			success = true;
			dispatchEvent(new FacebookEvent(FacebookEvent.COMPLETE, false, false, true, result));
		}
		
		/**
		 * A utility method used by extended classes.  The exception is
		 * passed to this method from the handleResult method.
		 * This method should NOT be called directly.
		 */
		facebook_internal function handleError(error:FacebookError):void {
			this.error = error;
			success = false;
			dispatchEvent(new FacebookEvent(FacebookEvent.COMPLETE, false, false, false, null, error));
		}
		
		protected function applySchema(p_shema:Array, ...p_args:Array):void {
			var l:uint = p_shema.length;
			
			for (var i:uint=0;i<l;i++) {
				setRequestArgument(p_shema[i], p_args[i]);
			}
		}

	}
}