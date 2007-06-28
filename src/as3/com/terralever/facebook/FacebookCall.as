/*
Copyright (c) 2007 Terralever

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
 * @author Chris Hill
 */
package com.terralever.facebook
{
	import flash.events.EventDispatcher;
	import com.gsolo.encryption.MD5;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	import flash.events.Event;
	import mx.logging.Log;
	import flash.events.ErrorEvent;
	import mx.core.Application;
	import flash.events.IOErrorEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.events.ResultEvent;
	
	public class FacebookCall extends EventDispatcher
	{
		// VARIABLES //////////
		
		private static var callID:int = 0;
		
		private var _fb:Facebook;
		private var _args:Object = {};
		private var _xml:XML;
		
		// CONSTRUCTION //////////
		
		function FacebookCall(fBook:Facebook)
		{
			this._fb = fBook;

			setRequestArgument("v", "1.0");
			
			if(_fb.api_key != null)
				setRequestArgument("api_key", _fb.api_key);

			if(_fb.session_key != null)
				setRequestArgument("session_key", _fb.session_key);

			// adding time to callID for safer uniqueness - still problematic if lots of clients!
			var call_id:String = ( new Date().valueOf() ).toString() + ( FacebookCall.callID++ ).toString();
			this.setRequestArgument( 'call_id', call_id );

			//add ALL fb_sig arguments to request. 
			//The server will use these to authenticate that our user is who he says he is.
			if(_fb.sessionType == FacebookSessionType.WIDGET_APP || _fb.useRedirectServer)
			{
				for(var prop:String in _fb.fb_sig_values)
				{
					this.setRequestArgument(prop, _fb.fb_sig_values[prop]); 
				}
			}
		}
		
		// PUBLIC FUNCTIONS //////////
		
		/**
		 * Send this call to the server
		 */
		public function post(method:String="no_method_required", url:String=null, forceSig:Boolean=false):void
		{
			if(url == null) url = _fb.rest_url;
			
			this.setRequestArgument( 'method', method );
			
			//we only need to create a sig if we're NOT using a redirect server.
			//otherwise the server is going to create the sig property on our behalf
			if(!_fb.useRedirectServer || forceSig)
			{
				//create encrypted signature. NOTE: You cannot use setRequestArgument() after calling this or you will bork the checksum!!
				this.setRequestArgument("sig", this.sig);
			}
			
			//create the service request
			var req:HTTPService = new HTTPService();
			req.contentType = "application/x-www-form-urlencoded";
			req.method = URLRequestMethod.POST;
			req.request = _args;
			req.url = url;
			req.resultFormat = "e4x";
			req.addEventListener(ResultEvent.RESULT, onResult);
			
			//construct the log message
			var debugString:String = "> > > sending facebook message:\n" + req.toString() + "\n args:";
			for(var indexName:String in this._args)
				debugString += "\n " + indexName + " = " + this._args[indexName];
			Log.getLogger("terralever.facebook").debug(debugString);			

			//make the request!
			req.send();
			
		}
		
		/**
		 * Set a name value pair to be sent in request postdata
		 */
		public function setRequestArgument( name:String, value:String ):void
		{
			this._args[name] = value;	
		}
		
		public function getResponse():XML
		{
			return _xml;
		}
		
		public function getResponseArgument(name:String):*
		{
			//TODO: Figure out how to pull that value from the XML.  It should be easy but I can't figure out how!
			return null;
		}

		// PRIVATE FUNCTIONS //////////
		
		private function onResult(event:ResultEvent):void
		{
			trace("got a result");
			//pull the XML out of the loader
			_xml = new XML(event.result);
			
			default xml namespace = _fb.FACEBOOK_NAMESPACE;

			//dispatch the response
			Log.getLogger("terralever.facebook").debug("< < < received facebook reply:\n" + _xml.toXMLString());

			if(_xml..error_code == undefined)
			{
				//all is well in the kingdom
				dispatchEvent(new Event(Event.COMPLETE));
			}
			
			else
			{
				//all is NOT well in the kingdom!
				Log.getLogger("terralever.facebook").warn("!THERE WAS A FACEBOOK ERROR!" + _xml..code + ":" + _xml..msg);
				//dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
			}
		}
		
		/**
		 * Construct the signature as described by Facebook api documentation
		 * (will only be used if NOT using a redirect server)
		 */
		private function get sig():String
		{
			var a:Array = [];
			
			for( var p:String in this._args )
			{
				if( p !== 'sig' ){
					a.push( p + '=' + this._args[p] );
				}
			}
			
			a.sort();
			
			var s:String = '';
			
			for( var i:Number = 0; i < a.length; i++ )
			{
				s += a[i];
			}
			
			s += _fb.secret;
			
			return MD5.encrypt( s );
		}	
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			//do nothing with unhandled ioError events
		}
		
		
	}
}