package com.pbking.facebook.delegates
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.session.IFacebookSession;
	
	public interface IFacebookCallDelegate
	{
		function get call():FacebookCall;
		function set call(newVal:FacebookCall):void;

		function get session():IFacebookSession;
		function set session(newVal:IFacebookSession):void;
	}
}