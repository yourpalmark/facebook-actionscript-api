package com.facebook.commands.photos {
	
	import com.facebook.data.photos.FacebookPhoto;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;
	
	/**
	 * The UploadPhoto class represents the public  
      Facebook API known as Photos.upload.
	 * @see http://wiki.developers.facebook.com/index.php/Photos.upload
	 */
	public class UploadPhoto extends FacebookCall {

		
		public static const METHOD_NAME:String = 'photos.upload';
		public static const SCHEMA:Array = ['data', 'aid', 'caption', 'uid'];
		
		public var data:Object;
		public var aid:String;
		public var caption:String;
		public var uid:String;
		
		public var uploadedPhoto:FacebookPhoto;
		
		/**
		 * Used to chnage type of Uploaded photos, used to automatically Convert BitmapData into an facebook supported Image.
		 * @see UploadPhotoTypes
		 * 
		 */
		public var uploadType:String = UploadPhotoTypes.JPEG;
		
		/**
		 * Used to assign the quality to an UploadPhotoTypes.JPEG uploadType; 
		 * 
		 */
		public var uploadQuality:uint = 80;
		
		public function UploadPhoto(data:Object=null, aid:String=null, caption:String=null, uid:String = null) {
			super(METHOD_NAME);
			
			this.data = data;
			this.aid = aid;
			this.caption = caption;
			this.uid = uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, data, aid, caption, uid);
			super.facebook_internal::initialize();
		}
	}
}