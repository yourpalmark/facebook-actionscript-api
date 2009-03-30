/**
 * http://wiki.developers.facebook.com/index.php/Data.setAssociations
 * FEB 23/ 09
 */ 
package com.facebook.commands.data {
	
	import com.facebook.data.data.SetAssociationsDataCollection;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The SetAssociations class represents the public  
      Facebook API known as Data.setAssociations.
	 * @see http://wiki.developers.facebook.com/index.php/Data.setAssociations
	 */
	public class SetAssociations extends FacebookCall {

		
		public static const METHOD_NAME:String = 'data.setAssociations';
		public static const SCHEMA:Array = ['assocs', 'name'];
		
		protected var assocs:SetAssociationsDataCollection;
		protected var name:String;
		
		public function SetAssociations(assocs:SetAssociationsDataCollection, name:String = null) {
			super(METHOD_NAME);
			
			this.assocs = assocs;
			this.name = name;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, assocs, name);
			super.facebook_internal::initialize();
		}
	}
}