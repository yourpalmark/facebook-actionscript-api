package com.pbking.util.logging
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	[Event(name="log", type="com.pbking.util.logging.PBLogEvent")]

	public class PBLogger extends EventDispatcher
	{
		// VARIABLES //////////
		
		public static var bridged:Boolean = false;

		private static var _loggers:Dictionary = new Dictionary();
		private static var _constructionLocked:Boolean = true;
		private static var _logAddedCallbacks:Array = [];
		private var _category:String;		
		
		// CONSTRUCTION //////////
		
		public static function getLogger(category:String="default"):PBLogger
		{
			var gotLogger:PBLogger = _loggers[category];
			if(!gotLogger)
				gotLogger = createLogger(category);
			return gotLogger;
		}
		
		private static function createLogger(category:String):PBLogger
		{
			//create the logger
			_constructionLocked = false;
			var newLogger:PBLogger = new PBLogger(category);
			_constructionLocked = true;
			
			//store it
			_loggers[category] = newLogger;
			
			//inform the listeners
			for each(var funct:Function in _logAddedCallbacks)
			{
				funct(newLogger);
			}
			
			//return the logger
			return newLogger;
		}
		
		function PBLogger(category:String)
		{
			if(_constructionLocked)
			{
				throw new Error("PBLogger should be created by calling PBLogger.getLogger('category') NOT by instantiating a new logger");
			}
			
			this._category = category;
		}
		
		// STATIC FUNCTIONS //////////

		public static function get log():PBLogger
		{
			return getLogger();
		}
		
		public static function allLoggers():Array
		{
			var allLoggers:Array = [];
			for each(var aLogger:PBLogger in _loggers)
				allLoggers.push(aLogger);
				
			return allLoggers;
		}
		
		public static function addLogAddedCallback(funct:Function):void
		{
			_logAddedCallbacks.push(funct);
		}
		
		// PUBLIC FUNCTIONS //////////
		
		public function get category():String
		{
			return _category;
		}
		
		public function log(message:String, level:int):void
		{
			//if the logger is "bridged" to the flex logger framework it's going to be traced already
			//we don't want to trace it twice
			if(!bridged)
				trace(message);
				
			dispatchEvent(new PBLogEvent(message, level, _category));
		}
		
		public function debug(message:String):void
		{
			log(message, PBLogLevel.DEBUG);
		}
		
		public function info(message:String):void
		{
			log(message, PBLogLevel.INFO);
		}
		
		public function warn(message:String):void
		{
			log(message, PBLogLevel.WARN);
		}
		
		public function error(message:String):void
		{
			log(message, PBLogLevel.ERROR);
		}
		
		public function fatal(message:String):void
		{
			log(message, PBLogLevel.FATAL);
		}
		
	}
}