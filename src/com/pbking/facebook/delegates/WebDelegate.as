package com.pbking.facebook.delegates
{
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.session.IFacebookSession;
	import com.pbking.facebook.session.DesktopSession;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	import com.pbking.facebook.session.WebSession;
	
	public class WebDelegate implements IFacebookCallDelegate
	{
		// VARIABLES //////////
		
		private static var callID:int = 0;
		private static var logger:PBLogger = PBLogger.getLogger("pbking.facebook");
		
		private var _call:FacebookCall;
		private var _session:WebSession;
		
		// GETTERS and SETTERS //////////
		
		public function get call():FacebookCall { return _call; }
		public function set call(newVal:FacebookCall):void { _call = newVal; }

		public function get session():IFacebookSession { return _session; }
		public function set session(newVal:IFacebookSession):void { _session = newVal as WebSession; }

		// CONSTRUCTION //////////

		public function WebDelegate(call:FacebookCall, session:WebSession)
		{
			this.call = call;
			this.session = session;
			
			execute();
		}

		// UTILITIES //////////

		protected function execute():void
		{
			if(!call)
			{
				logger.warn("LocalDebugDelegate can't execute; no call defined");
				return;
			}
			
			//construct the log message
			var debugString:String = "> > > calling method [direct]: " + call.method;
			for(var indexName:String in call.args)
			{
				debugString += "\n  +" + indexName + " = " + call.args[indexName];
			}
			logger.debug(debugString);
					
			post();
		}

		/**
		 * Helper function for sending the call straight to the server
		 */
		protected function post():void
		{	
			call.setRequestArgument("v", session.api_version);
			call.setRequestArgument("format", "JSON");
			
			if(session.api_key != null)
				call.setRequestArgument("api_key", session.api_key);

			if(session.session_key != null)
				call.setRequestArgument("session_key", session.session_key);

			var call_id:String = ( new Date().valueOf() ).toString() + ( callID++ ).toString();
			call.setRequestArgument( 'call_id', call_id );

			call.setRequestArgument( 'method', call.method );
			
			addOptionalArguments();
			
			//create encrypted signature. NOTE: You cannot use setRequestArgument() after calling this or you will bork the checksum!!
			if(!session.is_sessionless)
				call.setRequestArgument("sig", getSig());
			
			//construct the loader
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onResult);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);

			/*
			 * this is a special case.
			 * uploading photos.
			 * we can't do it through the JSBridge so I'm commenting it out for now
			 
			if(method == "facebook.photos.upload")
			{
				//special construction for uploads

				var mime:MIMEConstructor = new MIMEConstructor();
				var data:ByteArray;

				for(var argIndexName:String in this._args)
				{
					if(argIndexName != "data")
					{
						mime.writePostData(argIndexName, this._args[argIndexName]);
					}
					else
					{
						mime.writeFileData("fn"+this._args['call_id']+".jpg", this._args[argIndexName]); 
					}
				}
				mime.closePostData();

				var urlreq:URLRequest = new URLRequest();
				urlreq.method = URLRequestMethod.POST;
				urlreq.contentType = "multipart/form-data; boundary="+mime.getBoundary();
				urlreq.data = mime.getPostData();
				urlreq.url = session.rest_url;
				
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.load(urlreq);				
			}
			else
			{
			*/
				//create the service request for normal calls
				var req:URLRequest = new URLRequest(_session.rest_url);
				req.contentType = "application/x-www-form-urlencoded";
				req.method = URLRequestMethod.POST;
				req.data = call.args;
				
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				
				//make the request!
				loader.load(req);
			/*	
			}
			*/
		}
		
		/**
		 * Add arguments here that might be class session-type specific
		 */
		protected function addOptionalArguments():void
		{
			//setting thes 'ss' argument (secret session) to true
			//since that's what we should be using for a web session
			if(!session.is_sessionless)
				call.setRequestArgument( "ss", true );
		}
		
		/**
		 * Construct the signature as described by Facebook api documentation
		 */
		protected function getSig():String
		{
			var a:Array = [];
			
			for( var p:String in call.args )
			{
				var arg:* =call.args[p];
				if( p !== 'sig' && !(arg is ByteArray)){
					a.push( p + '=' + arg.toString() );
				}
			}
			
			a.sort();
			
			var s:String = '';
			
			for( var i:Number = 0; i < a.length; i++ )
			{
				s += a[i];
			}
			
			s += session.secret;
			
			return MD5.hash( s );
		}	
		
		// EVENT HANDLERS //////////
		
		protected function onError(event:ErrorEvent):void
		{
			var loader:URLLoader = event.target as URLLoader;
			
			loader.removeEventListener(Event.COMPLETE, onResult);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);

			call.handleResult(null, event);
		}
		
		protected function onResult(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;

			loader.removeEventListener(Event.COMPLETE, onResult);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);

			var resultString:String = loader.data;
			
			var result:Object = JSON.decode(resultString);

			logger.debug("< < < received facebook reply [direct]:\n" + resultString);

			call.handleResult(result, null);
		}

	}
}