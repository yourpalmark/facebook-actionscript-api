package com.facebook.delegates {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.session.IFacebookSession;
	
	import flash.events.IEventDispatcher;
	
	public interface IFacebookCallDelegate extends IEventDispatcher {
		
		function close():void;
		
		function get call():FacebookCall;
		function set call(newVal:FacebookCall):void;
		
		function get session():IFacebookSession;
		function set session(newVal:IFacebookSession):void;
		
	}
	
}