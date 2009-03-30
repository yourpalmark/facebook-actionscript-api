package com.facebook.utils {
	
	import com.adobe.serialization.json.JSON;
	
	public class FacebookDataUtils {
		
		public static function formatDate(string:String):Date  {
			if (string == "" || string == null) { return null; }
			
			var date:Date = new Date();

			var parts:Array = string.split( " " );
			
			// See if we have formatted date
			if ( parts.length == 2 )  {
				var dateParts:Array = parts[0].split( "-" );
				var timeParts:Array = parts[1].split( ":" );
				
				date.setFullYear( dateParts[0] );
				date.setMonth( dateParts[1] - 1 ); // subtract 1 (Jan == 0)
				date.setDate( dateParts[2] );
				date.setHours( timeParts[0] );
				date.setMinutes( timeParts[1] );
				date.setSeconds( timeParts[2] );
			}  else  {
				//GMT
				date.setTime( parseInt( string ) * 1000 );
			}
			
			return date;
		}
		
		public static function toDateString(date:Date):String {
			if (date == null) { return null; }
			
			date.setDate(date.date+1);
			return date == null?null:date.getTime().toString().slice(0,10);
		}
		
		public static function toArrayString(array:Array):String {
			return array == null?null:array.join(',')
		}
		
		public static function supplantString(string:String, replaceObj:Object):String {
			var str:String = string;
			for (var n:String in replaceObj) {
				str = str.replace(new RegExp('\\{'+n+'\\}', 'g'), replaceObj[n]);
			}
			return str;
		}
		
		public static function facebookCollectionToJSONArray(value:FacebookArrayCollection):String {
			if (value == null) { return null; }
			
			return JSON.encode(value.toArray());
		}
		
		public static function toJSONValuesArray(array:Array):String {
			if (array == null) { return null; }
			
			var newArray:Array = [];
			var l:Number = array.length;
			for(var i:Number=0;i<l;i++) {
				newArray.push(JSON.encode(array[i]));
			}
			return newArray.join(',');
		} 
	}
}