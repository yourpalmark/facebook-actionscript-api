/**
 * http://wiki.developers.facebook.com/index.php/Photos.createAlbum
 * Feb 16/09
 * 
 */ 
package com.facebook.commands.photos {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The CreateAlbum class represents the public  
      Facebook API known as Photos.createAlbum.
	 * @see http://wiki.developers.facebook.com/index.php/Photos.createAlbum
	 */
	public class CreateAlbum extends FacebookCall {

		
		public static const METHOD_NAME:String = 'photos.createAlbum';
		public static const SCHEMA:Array = ['name','location','description','visible','uid'];
		
		public var name:String;
		public var location:String;
		public var description:String;
		public var visible:String;
		public var uid:String;
		
		public function CreateAlbum(name:String, location:String="", description:String="", visible:String="", uid:String=null) {
			super(METHOD_NAME);
			
			this.name = name;
			this.location = location;
			this.description = description;
			this.visible = visible;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, name, location, description, visible, uid);
			super.facebook_internal::initialize();
		}
	}
}