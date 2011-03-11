package com.facebook.graph.data.api.review
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.application.FacebookApplication;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	use namespace facebook_internal;
	
	/**
	 * A review for an application.
	 * @see http://developers.facebook.com/docs/reference/api/review
	 */
	public class FacebookReview extends AbstractFacebookGraphObject
	{
		/**
		 * The timedate the review was created.
		 */
		public var created_time:Date;
		
		/**
		 * The user that created the review.
		 */
		public var from:FacebookUser;
		
		/**
		 * The review text (optional).
		 */
		public var message:String;
		
		/**
		 * The review rating.
		 */
		public var rating:int;
		
		/**
		 * The application to which this review applies.
		 */
		public var to:FacebookApplication;
		
		/**
		 * Creates a new FacebookReview.
		 */
		public function FacebookReview()
		{
		}
		
		/**
		 * Populates and returns a new FacebookReview from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookReview.
		 */
		public static function fromJSON( result:Object ):FacebookReview
		{
			var review:FacebookReview = new FacebookReview();
			review.fromJSON( result );
			return review;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case FacebookReviewField.FROM:
					from = FacebookUser.fromJSON( value );
					break;
				
				case FacebookReviewField.TO:
					to = FacebookApplication.fromJSON( value );
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
			return facebook_internal::toString( [ FacebookReviewField.ID, FacebookReviewField.RATING ] );
		}
		
	}
}