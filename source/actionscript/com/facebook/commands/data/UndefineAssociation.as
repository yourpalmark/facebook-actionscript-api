/**
 * http://wiki.developers.facebook.com/index.php/Data.undefineAssociation
 * FEB 24/09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The UndefineAssociation class represents the public  
      Facebook API known as Data.undefineAssociation.
	 * @see http://wiki.developers.facebook.com/index.php/Data.undefineAssociation
	 */
	public class UndefineAssociation extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.undefineAssociation';
		public static const SCHEMA:Array = ['name'];
		
		public var name:String;
		
		public function UndefineAssociation(name:String) {
			super(METHOD_NAME);
			
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, this.name);
			super.facebook_internal::initialize();
		}
	}
}