package com.pbking.util.logging
{
	import flash.utils.Dictionary;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	
	public class PBLogBridge
	{
		private static var logHash:Dictionary = new Dictionary();
		private static var initialized:Boolean = false;
		
		public static function initialize():void
		{
			if(!initialized)
			{
				//first add all existing loggers
				for each(var logger:PBLogger in PBLogger.allLoggers())
					onLoggerAddedCallback(logger);
					
				//now listen for new ones
				PBLogger.addLogAddedCallback(onLoggerAddedCallback);
				
				PBLogger.bridged = true;
				
				initialized = true;
			}
		}
		
		private static function onLoggerAddedCallback(pbLogger:PBLogger):void
		{
			var flexLogger:ILogger;
			
			flexLogger = Log.getLogger(pbLogger.category);
			logHash[pbLogger] = flexLogger;
			
			pbLogger.addEventListener(PBLogEvent.LOG, onPbLog);
		}
		
		private static function onPbLog(event:PBLogEvent):void
		{
			var flexLogger:ILogger = logHash[event.target] as ILogger;
			if(flexLogger)
				flexLogger.log(event.level, event.message);
		}
	}
}