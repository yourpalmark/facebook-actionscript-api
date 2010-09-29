package com.facebook.commands.graph.core
{
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class GetLoginStatus extends FacebookCall
	{
		public static const CORE_METHOD_NAME:String = "getLoginStatus";
		public static const SCHEMA:Array = [ 'force' ];
		
		public var force:Boolean;
		
		public function GetLoginStatus( force:Boolean=false )
		{
			super();
			coreMethod = CORE_METHOD_NAME;
			cbIndex = 0;
			
			this.force = force;
		}
		
		override facebook_internal function initialize():void
		{
			applySchema( SCHEMA, force );
			
			super.facebook_internal::initialize();
		}
		
	}
}