
/**
 * Facebook API top level class. 
 * Provides internal configuration with login and authentication helpers.
 * @see http://developers.facebook.com/documentation.php
 * @author Tim Whitlock <tim at white interactive dot com>
 */


import com.facebook.FacebookXML;

/**
 *
 */
class com.facebook.Facebook extends Object {
	
	#include "version.as"
	
	/** URL of Facebook api server or proxy/redirect script */
	static function get REST_URL():String {
		return 'http://api.facebook.com/restserver.php';
	}
	
	/** Your applications registred API key - obtained from Facebook */
	static function get API_KEY():String {
		return '00000000000000000000000000000000';
	}
	
	/** The secret that is paired with your API key - obtained from Facebook */
	static function get SECRET():String {
		return '00000000000000000000000000000000';
	}
	
	/** HTTP User Agent to send in api requests */
	private static var userAgent:String;
	static function get USER_AGENT():String {
		if( Facebook.userAgent == null ){
			var fvers:String = _root.$version.split(' ').join('-').split(',').join('.');
			Facebook.userAgent = 'ActionScript/2.0 (http://whiteinteractive.com/facebook/asclient.php) Flash/'+fvers;	
		}
		return Facebook.userAgent;
	}
	
	/** session key set by initial login call */
	private static var sessionKey:String = '';
	static function get SESSION_KEY():String {
		return Facebook.sessionKey;
	}
	
	/** user id set by initial login call */
	private static var userID:String = '0';
	static function get UID():String {
		return Facebook.userID;
	}
	
	
	
	/** public callbacks for session initialization */
	public static var onSessionStart:Function;
	public static var onSessionFail:Function;
	public static var onSessionTimeout:Function;
	
	
	
	/**
	 * Start session with userID and sessionKey.
	 * These values will be globally available as pseudo constants Facebook.SESSION_KEY & Facebook.UID
	 * @param String session key obtained from "facebook.auth.getSession"
	 * @param String user id of logged in user for this session
	 * @param Number session expiry timestamp (seconds)
	 */
	static function startSession( key:String, uid:String, expires:Number ):Void {
		// set timeout function for expiry of current session
		if( expires && !isNaN(expires) ){
			var now:Number = new Date().getTime();
			var exp:Number = expires * 1000;
			var ttl:Number = exp - now;
			if( ttl <= 0 ){
				Facebook.onSessionTimeout();
				return;
			}
			// create anonymous timeout function which calls onSessionTimeout
			var timeoutID:Number = setInterval(
				function():Void {
					clearInterval( timeoutID );
					delete timeoutID;
					Facebook.sessionKey = '';
					Facebook.userID = '0';
					Facebook.onSessionTimeout();
				},
				ttl
			);
		}
		// set current session params
		Facebook.sessionKey = key;
		Facebook.userID = uid;
		// invoke session start handler
		Facebook.onSessionStart();
	}
	



	/**
	 * Log into Facebook using a remote wrapper script of your own design.
	 * The script at this URL must return the XML resonse from the Facebook api call to "Facebook.auth.getSession"
	 * @param string url of wrapper script
	 * @return Boolean whether post was successfuly sent
	 */
	static function login( url:String ):Boolean {
		var fb_xml:FacebookXML = new FacebookXML();
		fb_xml.onLoad = function():Void{
			var u:String = this.getResponseArgument('uid');
			var s:String = this.getResponseArgument('session_key');
			var t:Number = Number( this.getResponseArgument('expires') );
			if( u == null || s == null ){
				Facebook.onSessionFail('Bad response from remote login script');
			}
			else {
				Facebook.startSession( s, u, t );
			}
		}
		fb_xml.onError = function( detail:String ):Void{
			Facebook.onSessionFail( detail );
		}
		// compile fb_sig_* args
		for( var s:String in _root ){
			if( s.indexOf('fb_sig_') === 0 ){
				fb_xml.setRequestArgument( s, _root[s] );
			}
		}
		return fb_xml.post( null, url );
	}
	
	
	
	
	
	/**
	 * Log into Facebook with an auth token already obtained outside of Flash.
	 * @param string auth token obtained from Facebook application login
	 * @return Boolean whether post was successfuly sent
	 */
	static function authenticate( token:String ):Boolean {
		var X:FacebookXML = new FacebookXML();
		X.setRequestArgument( 'auth_token', token );
		X.onLoad = function():Void{
			var u:String = X.getResponseArgument('uid');
			var s:String = X.getResponseArgument('session_key');
			var t:Number = Number( X.getResponseArgument('expires') );
			if( u == null || s == null ){
				Facebook.onSessionFail('Failed to authenticate with token:' + token );
			}
			else {
				Facebook.startSession( s, u, t );
			}
		}
		X.onError = function( detail:String ):Void{
			Facebook.onSessionFail( 'Failed to authenticate with token:' + token + newline + detail );
		}
		return X.post( 'facebook.auth.getSession',  Facebook.REST_URL );
	}
	
	
	
	
	
	
	
}