package com.pbking.facebook.data.util
{
	public class FacebookDataParser
	{
		public static function formatDate(string:String):Date 
		{
			if ( string == "" || string == null)
				return null;
			
			var date:Date = new Date();

			var parts:Array = string.split( " " );
			
			// See if we have formatted date
			if ( parts.length == 2 ) 
			{
				var dateParts:Array = parts[0].split( "-" );
				var timeParts:Array = parts[1].split( ":" );
				
				date.setFullYear( dateParts[0] );
				date.setMonth( dateParts[1] - 1 ); // subtract 1 (Jan == 0)
				date.setDate( dateParts[2] );
				date.setHours( timeParts[0] );
				date.setMinutes( timeParts[1] );
				date.setSeconds( timeParts[2] );
			} 
			else 
			{
				//GMT
				date.setTime( parseInt( string ) * 1000 );
			}
			
			return date;
		}
	}
}