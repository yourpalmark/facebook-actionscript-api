package com.facebook.commands.graph.core
{
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	
	use namespace facebook_internal;
	
	public class Logout extends FacebookCall
	{
		public static const CORE_METHOD_NAME:String = "logout";
		public static const SCHEMA:Array = [];
		
		public function Logout()
		{
			super();
			coreMethod = CORE_METHOD_NAME;
			cbIndex = 0;
		}
		
		override facebook_internal function initialize():void
		{
			super.facebook_internal::initialize();
		}
		
	}
}