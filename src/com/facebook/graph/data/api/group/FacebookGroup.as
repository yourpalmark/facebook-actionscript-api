package com.facebook.graph.data.api.group
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.data.api.core.AbstractFacebookGraphObject;
	
	use namespace facebook_internal;
	
	/**
	 * A Facebook group.
	 * @see http://developers.facebook.com/docs/reference/api/group
	 */
	public class FacebookGroup extends AbstractFacebookGraphObject
	{
		/**
		 * The URL for the group's icon.
		 */
		public var icon:String;
		
		/**
		 * The profile that created this group.
		 */
		public var owner:Object;
		
		/**
		 * The name of the group.
		 */
		public var name:String;
		
		/**
		 * A brief description of the group.
		 */
		public var description:String;
		
		/**
		 * The URL for the group's website.
		 */
		public var link:String;
		
		/**
		 * The privacy setting of the group.
		 */
		public var privacy:String;
		
		/**
		 * The last time the group was updated.
		 */
		public var updated_time:Date;
		
		/**
		 * Creates a new FacebookGroup.
		 */
		public function FacebookGroup()
		{
		}
		
		/**
		 * Populates and returns a new FacebookGroup from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 * 
		 * @return A new FacebookGroup.
		 */
		public static function fromJSON( result:Object ):FacebookGroup
		{
			var group:FacebookGroup = new FacebookGroup();
			group.fromJSON( result );
			return group;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return facebook_internal::toString( [ FacebookGroupField.ID, FacebookGroupField.NAME ] );
		}
		
	}
}