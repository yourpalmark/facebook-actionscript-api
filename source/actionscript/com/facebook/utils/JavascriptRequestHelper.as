package com.facebook.utils {
	
	import flash.net.URLVariables;
	import flash.utils.getQualifiedClassName;
	
	public class JavascriptRequestHelper {
		
		public static function formatURLVariables(urlVars:URLVariables):String {
			var filter:Object = {method:true, sig:true, api_key:true, call_id:true};
			
			var hasParams:Boolean =  false;
			var obj:Object = {};
			for (var n:String in urlVars) {
				if (filter[n]) { continue; }
				hasParams = true;
				obj[n] = urlVars[n];
			}
			return hasParams?objectToString(obj):'null';
		}
		
		public static function formatParams(params:Array):String {
			var newParams:Array = [];
			var l:uint = params.length;
			for (var i:uint=0;i<l;i++) {
				var value:Object = params[i];
				var qualifiedClassName:String = getQualifiedClassName(value);
				switch (qualifiedClassName) {
					case 'Array':
						value = '['+value.join(', ')+']'; break;
					case 'Object':
						value = objectToString(value); break;
					case 'String':
					default:
						value = '"'+value+'"'; break;
				}
				newParams.push(value);
			}
			return newParams.join(', ');
		}
		
		public static function objectToString(obj:Object):String {
			var arr:Array = [];
			for (var n:String in obj) {
				arr.push(n + ': ' + quote(obj[n]) + '');
			}
			return '{' + arr.join(', ') +' }';
		}
		
		public static function quote(p_string:String):String {
			var regx:RegExp = /[\\"\r\n]/g;
			return '"'+ p_string.replace(regx, _quote) +'"';
		}
		
		protected static function _quote(p_string:String, ...args):String {
			switch (p_string) {
				case "\\":
					return "\\\\";
				case "\r":
					return "\\r";
				case "\n":
					return "\\n";
				case '"':
					return '\\"';
			}
			return null;
		}
	}
}