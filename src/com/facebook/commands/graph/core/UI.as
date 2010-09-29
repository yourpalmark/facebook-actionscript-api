package com.facebook.commands.graph.core
{
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class UI extends FacebookCall
	{
		public static const CORE_METHOD_NAME:String = "ui";
		public static const SCHEMA:Array = [ 'params' ];
		
		protected var _params:Object;
		
		public function UI( params:Object=null )
		{
			super( method );
			coreMethod = CORE_METHOD_NAME;
			
			this.params = params;
		}
		
		public function get params():Object
		{
			return _params;
		}
		public function set params( value:Object ):void
		{
			_params = value;
			for( var name:String in value )
			{
				if( hasOwnProperty( name ) )
				{
					this[ name ] = value[ name ];
				}
			}
		}
		
		override facebook_internal function initialize():void
		{
			formatParams();
			
			applySchema( SCHEMA, params );
			
			super.facebook_internal::initialize();
		}
		
		facebook_internal function formatParams():void
		{
			params = {};
			params.method = method;
		}
		
	}
}