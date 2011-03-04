package com.facebook.graph.data.api.core
{
	import com.facebook.graph.core.facebook_internal;
	import com.facebook.graph.utils.FacebookDataUtils;
	
	use namespace facebook_internal;
	
	/**
	 * Base class for all graph objects.
	 * This class is abstract and should not be instantiated directly.
	 */
	public class AbstractFacebookGraphObject implements IFacebookGraphObject
	{
		/**
		 * The unique ID for the graph object.
		 */
		public var id:String;
		
		/**
		 * The raw decoded JSON result data for the graph object.
		 */
		public var rawResult:Object;
		
		/**
		 * Creates a new AbstractFacebookGraphObject.
		 */
		public function AbstractFacebookGraphObject()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function fromJSON( result:Object ):void
		{
			rawResult = result;
			
			if( result != null )
			{
				for( var property:String in result )
				{
					if( hasOwnProperty( property ) ) setPropertyValue( property, result[ property ] );
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString():String
		{
			return facebook_internal::toString( [ "id" ] );
		}
		
		/**
		 * @private
		 */
		protected function setPropertyValue( property:String, value:* ):void
		{
			switch( property )
			{
				case "created_time":
				case "end_time":
				case "start_time":
				case "updated_time":
					this[ property ] = FacebookDataUtils.stringToDate( value );
					break;
				
				default:
					this[ property ] = value;
					break;
			}
		}
		
		/**
		 * @private
		 */
		facebook_internal function toString( properties:Array ):String
		{
			var str:String = '[ ';
			var len:int = properties.length;
			for( var i:int=0; i<len; i++ )
			{
				var property:String = properties[ i ];
				if( hasOwnProperty( property ) ) 
				{
					if( i > 0 ) str += ", ";
					str += property + ': ' + this[ property ];
				}
			}
			str += ' ]';
			return str;
		}
		
	}
}