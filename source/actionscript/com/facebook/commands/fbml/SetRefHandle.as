/**
 * http://wiki.developers.facebook.com/index.php/Fbml.setRefHandle
 * FEB 23/09
 */ 
package com.facebook.commands.fbml {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The SetRefHandle class represents the public  
      Facebook API known as Fbml.setRefHandle.
	 * @see http://wiki.developers.facebook.com/index.php/Fbml.setRefHandle
	 */
	public class SetRefHandle extends FacebookCall {

		
		public static const METHOD_NAME:String = 'fbml.setRefHandle';
		public static const SCHEMA:Array = ['handle','fmbl'];
		
		public var handle:String;
		public var fmbl:String;
		
		public function SetRefHandle(handle:String ,fmbl:String) {
			super(METHOD_NAME);
			
			this.handle = handle;
			this.fmbl = fmbl;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, handle, fmbl); 
			super.facebook_internal::initialize();
		}
	}
}