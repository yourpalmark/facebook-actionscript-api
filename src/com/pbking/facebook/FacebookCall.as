/*
Copyright (c) 2007 Jason Crist

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

/**
 * Makes the call to the Facebook REST service  
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook
{
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.pbking.util.logging.PBLogger;
	import com.shtif.web.MIMEConstructor;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	public class FacebookCall extends EventDispatcher
	{
		// VARIABLES //////////
		
		private static var callID:int = 0;
		
		private var externalInterfaceInitialized:Boolean;
		private var logger:PBLogger = PBLogger.getLogger("pbking.facebook");
		
		private var _fb:Facebook;
		private var _args:URLVariables = new URLVariables();
		
		[Bindable] public var result:Object;
		[Bindable] public var exception:Object;
		
		// CONSTRUCTION //////////
		
		function FacebookCall(fBook:Facebook)
		{
			this._fb = fBook;
		}
		
		// PUBLIC FUNCTIONS //////////
		
		/**
		 * Send this call to the server
		 */
		public function post(method:String="no_method_required", url:String=null):void
		{
			//construct the log message
			var debugString:String = "> > > calling method: " + method;
			for(var indexName:String in this._args)
				debugString += "\n  +" + indexName + " = " + this._args[indexName];
			logger.debug(debugString);
					
			if(_fb.sessionType == FacebookSessionType.JAVASCRIPT_BRIDGE)
				post_bridge(method);
			else
				post_direct(method, url);
		}
		
		/**
		 * Helper function for sending the call through the javascript bridge
		 */
		private function post_bridge(method:String):void
		{
			if(!externalInterfaceInitialized)
			{
				ExternalInterface.addCallback("bridgeFacebookReply", bridgeFacebookReply);
				externalInterfaceInitialized = true;
			}
			
			ExternalInterface.call("bridgeFacebookCall", method, _args);
		}
			
		/**
		 * Helper function for sending the call straight to the server
		 */
		private function post_direct(method:String, url:String=null):void
		{	
			if(url == null) url = _fb.rest_url;

			setRequestArgument("v", _fb.api_version);
			
			setRequestArgument("format", "JSON");
			
			if(_fb.api_key != null)
				setRequestArgument("api_key", _fb.api_key);

			if(_fb.session_key != null)
				setRequestArgument("session_key", _fb.session_key);

			var call_id:String = ( new Date().valueOf() ).toString() + ( FacebookCall.callID++ ).toString();
			this.setRequestArgument( 'call_id', call_id );

			this.setRequestArgument( 'method', method );
			
			//create encrypted signature. NOTE: You cannot use setRequestArgument() after calling this or you will bork the checksum!!
			this.setRequestArgument("sig", getSig());
			
			//construct the log message
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onResult);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);

			if(method != "facebook.photos.upload")
			{
				//create the service request
				var req:URLRequest = new URLRequest(url);
				req.contentType = "application/x-www-form-urlencoded";
				req.method = URLRequestMethod.POST;
				req.data = _args;
				
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				
				//make the request!
				loader.load(req);
			}
			else
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
				urlreq.url = url;
				
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.load(urlreq);				
			}
		}
		
		/**
		 * Set a name value pair to be sent in request postdata
		 */
		public function setRequestArgument( name:String, value:* ):void
		{
			this._args[name] = value;	
		}
		
		// PRIVATE FUNCTIONS //////////
		
		private function onError(event:ErrorEvent):void
		{
			dispatchEvent(event.clone());
		}
		
		private function onResult(event:Event):void
		{
			var loader:URLLoader = event.target as URLLoader;
			var resultString:String = loader.data;
			
			result = JSON.decode(resultString);

			logger.debug("< < < received facebook reply:\n" + resultString);

			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function bridgeFacebookReply(result:Object, exception:Object):void
		{
			this.result = result;
			this.exception = exception;
			
			//TODO: Check for & handle exception
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		/**
		 * Construct the signature as described by Facebook api documentation
		 */
		private function getSig():String
		{
			var a:Array = [];
			
			for( var p:String in this._args )
			{
				var arg:* = this._args[p];
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
			
			s += _fb.secret;
			
			return MD5.hash( s );
		}	
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			//do nothing with unhandled ioError events
		}
		
		
	}
}