package com.facebook.session {
	
	import com.facebook.delegates.IFacebookCallDelegate;
	import com.facebook.net.FacebookCall;
	
	import flash.events.IEventDispatcher;
	
	public interface IFacebookSession extends IEventDispatcher {
		
		function get is_connected():Boolean;

		function get waiting_for_login():Boolean;
		
		function get api_key():String; 

		function get secret():String;
		function set secret(value:String):void;
		
		function get rest_url():String;
		function set rest_url(value:String):void;
	
		function get session_key():String;
		function set session_key(value:String):void;
		
		function get expires():Date; 
	
		function get uid():String;

		function get api_version():String;
		
		function verifySession():void;
		
		function login(offline_access:Boolean):void;
		
		function refreshSession():void;
		
		function post(call:FacebookCall):IFacebookCallDelegate;
		 
	}
}