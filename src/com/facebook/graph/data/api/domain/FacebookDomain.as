package com.facebook.graph.data.api.domain
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A web site domain within the Graph API.
	 * @see http://developers.facebook.com/docs/reference/api/domain
	 */
	public class FacebookDomain extends AbstractFacebookGraphObject
	{
		/**
		 * The name of the domain.
		 */
		public var name:String;
		
		/**
		 * Creates a new FacebookDomain.
		 */
		public function FacebookDomain()
		{
		}
		
		/**
		 * Populates and returns a new FacebookDomain from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookDomain.
		 */
		public static function fromJSON( result:Object ):FacebookDomain
		{
			var domain:FacebookDomain = new FacebookDomain();
			domain.fromJSON( result );
			return domain;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookDomainField.ID, FacebookDomainField.NAME ] );
		}
		
	}
}