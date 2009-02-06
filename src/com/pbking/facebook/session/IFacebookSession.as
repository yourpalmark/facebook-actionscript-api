package com.pbking.facebook.session
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.delegates.IFacebookCallDelegate;
	import flash.events.IEventDispatcher;
	
	public interface IFacebookSession extends IEventDispatcher
	{
		function get is_connected():Boolean;

		function get waiting_for_login():Boolean;
		
		function get api_key():String; 

		function get secret():String; 
	
		function get session_key():String; 
		
		function get expires():Number; 
	
		function get uid():String;

		function get api_version():String;
		
		function get is_sessionless():Boolean; 

		function post(call:FacebookCall):IFacebookCallDelegate; 
	}
}