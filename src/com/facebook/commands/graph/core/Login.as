package com.facebook.commands.graph.core
{
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class Login extends FacebookCall
	{
		public static const CORE_METHOD_NAME:String = "login";
		public static const SCHEMA:Array = [ 'opts' ];
		
		public var opts:Object;
		
		public function Login( opts:Object=null )
		{
			super();
			coreMethod = CORE_METHOD_NAME;
			cbIndex = 0;
			
			this.opts = opts;
		}
		
		override facebook_internal function initialize():void
		{
			applySchema( SCHEMA, opts );
			
			super.facebook_internal::initialize();
		}
		
	}
}