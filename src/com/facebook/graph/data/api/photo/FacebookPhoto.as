package com.facebook.graph.data.api.photo
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * An individual photo within an album.
	 * @see http://developers.facebook.com/docs/reference/api/photo
	 */
	public class FacebookPhoto extends AbstractFacebookGraphObject
	{
		/**
		 * The profile (user or page) that posted this photo.
		 */
		public var from:Object;
		
		/**
		 * The tagged users and their positions in this photo.
		 */
		public var tags:Array;
		
		/**
		 * The caption given to this photo.
		 */
		public var name:String;
		
		/**
		 * The icon that Facebook displays when photos are published to the Feed.
		 */
		public var icon:String;
		
		/**
		 * The full-sized source of the photo.
		 */
		public var source:String;
		
		/**
		 * The height of the photo in pixels.
		 */
		public var height:int;
		
		/**
		 * The width of the photo in pixels.
		 */
		public var width:int;
		
		/**
		 * A link to the photo on Facebook.
		 */
		public var link:String;
		
		/**
		 * The time the photo was initially published.
		 */
		public var created_time:Date;
		
		/**
		 * The last time the photo or its caption was updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookPhoto.
		 */
		public function FacebookPhoto()
		{
		}
		
		/**
		 * Populates and returns a new FacebookPhoto from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookPhoto.
		 */
		public static function fromJSON( result:Object ):FacebookPhoto
		{
			var photo:FacebookPhoto = new FacebookPhoto();
			photo.fromJSON( result );
			return photo;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookPhotoField.TAGS:
					tags = [];
					var tagsData:Array = value is Array ? value : Object( value ).hasOwnProperty( "data" ) && value.data is Array ? value.data : [];
					for each( var tagData:Object in tagsData )
					{
						tags.push( FacebookPhotoTag.fromJSON( tagData ) );
					}
					break;
				
				default:
					super.setPropertyValue( property, value );
					break;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookPhotoField.ID, FacebookPhotoField.NAME ] );
		}
		
	}
}