/*
  Copyright (c) 2009, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package com.facebook.utils {
	
	import flash.net.URLVariables;
	import flash.utils.getQualifiedClassName;
	
	public class JavascriptRequestHelper {
		
		public static function formatURLVariables(urlVars:URLVariables, schema:Array, coreMethod:String):String {
			var formattedURLVars:String;
			if( !coreMethod ) {
				var filter:Object = getFilter( coreMethod );
				
				var hasParams:Boolean = false;
				var obj:Object = {};
				for (var n:String in urlVars) {
					if (filter[n]) { continue; }
					hasParams = true;
					obj[n] = urlVars[n];
				}
				formattedURLVars = hasParams ? objectToString( obj ) : 'null';
			}
			else
			{
				var callParams:Array = urlVarsToParams( urlVars, schema, coreMethod );
				formattedURLVars = callParams.length > 0 ? formatParams( callParams ) : 'null';
			}
			return formattedURLVars;
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
			return '{' + arr.join(', ') +'}';
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
		
		protected static function urlVarsToParams( urlVars:URLVariables, schema:Array, coreMethod:String):Array {
			var cloneVars:URLVariables = new URLVariables();
			var n:String;
			for (n in urlVars) {
				cloneVars[n] = urlVars[n];
			}
			var filter:Object = getFilter( coreMethod );
			var params:Array = [];
			var l:uint = schema ? schema.length : 0;
			for (var i:uint=0;i<l;i++) {
				n = schema[i];
				if (filter[n]) { continue; }
				if( cloneVars[n] )
				{
					params.push( cloneVars[n] );
					delete cloneVars[n];
				}
			}
			for (n in cloneVars) {
				if (filter[n]) { continue; }
				params.push( cloneVars[n] );
			}
			return params;
		}
		
		protected static function getFilter( coreMethod:String ):Object
		{
			var filter:Object = {sig:true, api_key:true, call_id:true, v:true};
			if( coreMethod && coreMethod != "api" ) filter.method = true;
			return filter;
		}
	}
}