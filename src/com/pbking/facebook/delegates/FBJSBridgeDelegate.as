package com.pbking.facebook.delegates
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.session.IFacebookSession;
	import com.pbking.facebook.session.FBJSBridgeSession;
	import flash.net.LocalConnection;
	import com.pbking.util.logging.PBLogger;

	public class FBJSBridgeDelegate implements IFacebookCallDelegate
	{
		private var _call:FacebookCall;
		private var _session:FBJSBridgeSession;

		private static var logger:PBLogger = PBLogger.getLogger("pbking.facebook");

		protected static var connection:LocalConnection = new LocalConnection();

		public function FBJSBridgeDelegate(call:FacebookCall, session:FBJSBridgeSession)
		{
			this.call = call;
			this.session = session;
			
			execute();
		}

		public function get call():FacebookCall { return _call;	}
		public function set call(newVal:FacebookCall):void { this._call = newVal; }
		
		public function get session():IFacebookSession { return _session; }
		public function set session(newVal:IFacebookSession):void { this._session = newVal as FBJSBridgeSession; }
		
		protected function execute():void
		{
			//construct the log message
			var debugString:String = "> > > calling method [fbjsb]: " + call.method;
			for(var indexName:String in call.args)
			{
				debugString += "\n  +" + indexName + " = " + call.args[indexName];
			}
			logger.debug(debugString);

			var a:Array = [];
			for each(var o:* in call.args)
				a.push(o);
			
			logger.debug("sending to: " + _session.bridgeSwfName);
				
			connection.send(_session.bridgeSwfName, "callFBJS", call.method, a);
		}
	}
}