package com.facebook.utils {
	
	import flash.system.Capabilities;
	
	public class PlayerUtils {
		
		protected static var versionObj:Object;
		
		public static function get platform():String {
			return parseVersionString().platform;
		}
		
		public static function get majorVersion():Number {
			return parseVersionString().majorVersion;
		}
		
		public static function get minorVersion():Number {
			return parseVersionString().minorVersion;
		}
		
		public static function get buildNumber():Number {
			return parseVersionString().buildNumber;
		}
		
		public static function get internalBuildNumber():Number {
			return parseVersionString().internalBuildNumber;
		}
		
		public static function parseVersionString():Object {
			if (versionObj != null) { return versionObj; }
			
			var version:String = Capabilities.version;
			versionObj = {};
			
			var peices1:Array = version.split(' '); 
			versionObj.platform = peices1[0];
			peices1.shift();
			peices1 = peices1[0].split(',');
			versionObj.majorVersion =  Number(peices1[0]);
			versionObj.minorVersion =  Number(peices1[1]);
			versionObj.buildNumber =  Number(peices1[2]);
			versionObj.internalBuildNumber =  Number(peices1[3]);
			return versionObj;
		}

	}
}