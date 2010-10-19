package com.facebook.graph.data.api.note
{
	import com.adobe.utils.DateUtil;
	import com.facebook.graph.data.api.user.FacebookUser;
	
	/**
	 * A Facebook note.
	 * @see http://developers.facebook.com/docs/reference/api/note
	 */
	public class FacebookNote
	{
		/**
		 * The note ID.
		 */
		public var id:String;
		
		/**
		 * The ID of the user who posted the note.
		 */
		public var from:FacebookUser;
		
		/**
		 * The title of the note.
		 */
		public var subject:String;
		
		/**
		 * The note content, an HTML string.
		 */
		public var message:String;
		
		/**
		 * The time the note was initially published.
		 */
		public var created_time:Date;
		
		/**
		 * The time the note was last updated.
		 */
		public var updated_time:Date;
		
		/**
		 * The note icon that Facebook displays with notes.
		 */
		public var icon:String;
		
		/**
		 * Creates a new FacebookNote.
		 */
		public function FacebookNote()
		{
		}
		
		/**
		 * Populates the note from a decoded JSON object.
		 */
		public function fromJSON( result:Object ):void
		{
			if( result != null )
			{
				for( var property:String in result )
				{
					switch( property )
					{
						case "from":
							from = new FacebookUser();
							from.fromJSON( result[ property ] );
							break;
						
						case "created_time":
							created_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						case "updated_time":
							updated_time = DateUtil.parseW3CDTF( result[ property ] );
							break;
						
						default:
							if( hasOwnProperty( property ) ) this[ property ] = result[ property ];
							break;
					}
				}
			}
		}
		
		/**
		 * Provides the string value of the note.
		 */
		public function toString():String
		{
			return '[ id: ' + id + ', subject: ' + subject + ' ]';
		}
		
	}
}