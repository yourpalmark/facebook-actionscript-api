package com.facebook.commands.graph.core
{
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class API extends FacebookCall
	{
		public static const CORE_METHOD_NAME:String = "api";
		public static const SCHEMA:Array = [ 'path', 'method', 'params' ];
		
		public var path:String;
		public var params:Object;
		
		public function API( path:String=null, method:String=null, params:Object=null )
		{
			super();
			coreMethod = CORE_METHOD_NAME;
			
			this.path = path;
			this.method = method;
			this.params = params;
		}
		
		override facebook_internal function initialize():void
		{
			applySchema( SCHEMA, path, method, params );
			
			super.facebook_internal::initialize();
		}
		
	}
}