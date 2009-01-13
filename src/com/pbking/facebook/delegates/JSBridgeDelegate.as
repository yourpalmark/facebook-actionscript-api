package com.pbking.facebook.delegates
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.session.IFacebookSession;
	import com.pbking.facebook.session.JSBridgeSession;
	import com.pbking.util.logging.PBLogger;
	
	import flash.external.ExternalInterface;
	
	public class JSBridgeDelegate implements IFacebookCallDelegate
	{
		// VARIABLES //////////
		
		private static var initialized:Boolean;
		private static var externalInterfaceCalls:Object = {};
		private static var externalInterfaceCallId:int;
		
		private static var logger:PBLogger = PBLogger.getLogger("pbking.facebook");

		private var _call:FacebookCall;
		private var _session:JSBridgeSession;
		
		// GETTERS and SETTERS //////////
		
		public function get call():FacebookCall { return _call; }
		public function set call(newVal:FacebookCall):void { _call = newVal; }

		public function get session():IFacebookSession { return _session; }
		public function set session(newVal:IFacebookSession):void { _session = newVal as JSBridgeSession; }
		
		// CONSTRUCTION //////////
		
		public function JSBridgeDelegate(call:FacebookCall, session:JSBridgeSession)
		{
			initialize();
			
			this.call = call;
			this.session = session;
			
			execute();
		}
		
		private static function initialize():void
		{
			if(!initialized)
			{
				externalInterfaceCallId = 0;
				ExternalInterface.addCallback("bridgeFacebookReply", postBridgeAsyncReply);
				initialized = true;
			}
		}

		// INTERFACE REQUIREMENTS //////////
		
		protected function execute():void
		{
			if(!call)
			{
				logger.warn("JSBridgeDelegate can't execute; no call defined");
				return;
			}
			
			//construct the log message
			var debugString:String = "> > > calling method [jsb]: " + call.method;
			for(var indexName:String in call.args)
			{
				debugString += "\n  +" + indexName + " = " + call.args[indexName];
			}
			logger.debug(debugString);
					
			post()
		}

		// UTILS //////////

		protected function post():void
		{
			call.setRequestArgument("v", session.api_version);

			externalInterfaceCallId++;
			
			externalInterfaceCalls[externalInterfaceCallId] = call;
			
			var bridgeCallFunctionName:String = "bridgeFacebookCall_"+externalInterfaceCallId;

			var bridgeCall:String = 
				"function "+bridgeCallFunctionName+"(method, args){"+
					"FB.Facebook.apiClient._callMethod(method, args, " + 
							"function(result, exception){" + 
								"document."+_session.as_app_name+".bridgeFacebookReply(result, exception, "+externalInterfaceCallId+");" + 
							"});" + 
				"}";

			ExternalInterface.call(bridgeCall, call.method, call.args);
		}
		
		protected static function postBridgeAsyncReply(result:Object, exception:Object, exCallId:uint):void
		{
			logger.debug("< < < received facebook reply [jsb]:\n" + result.toString());

			var call:FacebookCall = externalInterfaceCalls[exCallId];

			call.handleResult(result, exception);			

			delete externalInterfaceCalls[exCallId];
		}
		

	}
}