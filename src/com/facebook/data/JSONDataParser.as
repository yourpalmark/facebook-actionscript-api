package com.facebook.data
{
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.graph.core.GetLoginStatusData;
	import com.facebook.data.graph.core.LoginData;
	import com.facebook.data.graph.core.LogoutData;
	import com.facebook.data.graph.core.PermissionsData;
	import com.facebook.data.graph.core.SessionData;
	import com.facebook.data.graph.core.SessionResponseData;
	import com.facebook.data.graph.event.SubscribeData;
	import com.facebook.data.graph.event.UnsubscribeData;
	import com.facebook.errors.FacebookError;
	import com.facebook.utils.IFacebookResultParser;
	
	public class JSONDataParser implements IFacebookResultParser
	{
		public function JSONDataParser()
		{
		}
		
		public function parse( response:*, coreMethodName:String, methodName:String ):FacebookData
		{
			var data:FacebookData;
			
			switch( coreMethodName )
			{
				case 'getLoginStatus':
					data = createSessionResponse( response, new GetLoginStatusData() );
					break;
				case 'login':
					data = createSessionResponse( response, new LoginData() );
					break;
				case 'logout':
					data = createSessionResponse( response, new LogoutData() );
					break;
				case 'Event.subscribe':
					data = createSessionResponse( response, new SubscribeData() );
					break;
				case 'Event.unsubscribe':
					data = createSessionResponse( response, new UnsubscribeData() );
					break;
				default:
					data = new JSONResultData();
					JSONResultData( data ).result = response;
					break;
			}
			
			data.rawResult = JSON.encode( response );
			
			return data;
		}
		
		public function createSessionResponse( data:Object, sessionResponse:SessionResponseData=null ):SessionResponseData
		{
			sessionResponse = sessionResponse ? sessionResponse : new SessionResponseData();
			
			if( !data ) return sessionResponse;
			
			sessionResponse.status = data.status;
			sessionResponse.session = createSession( data.session );
			sessionResponse.perms = createPermissions( data.perms ? JSON.decode( data.perms ) : data.perms );
			
			return sessionResponse;
		}
		
		public function createSession( data:Object ):SessionData
		{
			var session:SessionData = new SessionData();
			
			if( !data ) return session;
			
			session.accessToken = data.access_token;
			session.baseDomain = data.base_domain;
			session.expires = data.expires;
			session.secret = data.secret;
			session.sessionKey = data.session_key;
			session.sig = data.sig;
			session.uid = data.uid;
			
			return session;
		}
		
		public function createPermissions( data:Object ):PermissionsData
		{
			var permissions:PermissionsData = new PermissionsData();
			
			if( !data ) return permissions;
			
			permissions.extended = data.extended ? String( data.extended ).split( "," ) : [];
			permissions.user = data.user ? String( data.user ).split( "," ) : [];
			permissions.friends = data.friends ? String( data.friends ).split( "," ) : [];
			
			return permissions;
		}
		
		public function validateFacebookResponse( response:* ):FacebookError
		{
			var error:FacebookError = null;
			
			if( !response )
			{
				error = new FacebookError();
				error.rawResult = JSON.encode( response );
			}
			
			return error;
		}
		
	}
}