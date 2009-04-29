package com.facebook.streamdemo.utils {
	
	import com.chewtinfoil.utils.DateUtils;
	
	public class TimeFormatter {
		
		public static const HOUR_IN_MILLISECONDS:Number = 1000*60*60;
		public static const MINUTE_IN_MILLISECONDS:Number = 1000*60;
		public static const SECOND_IN_MILLISECONDS:Number = 1000;
		
		public static function dateToString(date:Date):String {
			var now:Date = new Date();
			
			var diff:Number = now.time - date.time;
			
			var hoursDiff:Number = diff / HOUR_IN_MILLISECONDS;
			var minutesDiff:Number = diff / MINUTE_IN_MILLISECONDS;
			var secondsDiff:Number = diff / SECOND_IN_MILLISECONDS;
			
			var flooredDiff:Number = hoursDiff << 0; 
			
			if (hoursDiff < .75) {
				return formatMinutesDiff(diff);
			} else if (hoursDiff > .75 && hoursDiff < 1 || flooredDiff == 1) {
				return 'About an hour ago.';
			} else if (flooredDiff < 11) {
				return 'About ' + flooredDiff + ' hours ago.';
			} else {
				return DateUtils.toString(date, 'ddd h:mmtt');
			}
		}
		
		protected static function formatMinutesDiff(diff:Number):String {
			var minutesDiff:Number = diff / MINUTE_IN_MILLISECONDS;
			if (diff < MINUTE_IN_MILLISECONDS) {
				return formatSecconds(diff);
			} else if ((minutesDiff<<0) > 1) {
				return (minutesDiff<<0) + " minutes ago."
			} else {
				return "1 minute ago."
			}
		}
		
		protected static function formatSecconds(diff:Number):String {
			var secondsDiff:Number = diff / SECOND_IN_MILLISECONDS << 0;
			if (secondsDiff > 1) {
				return secondsDiff + ' seconds ago.'
			} else {
				return 'Just now';
			}
		}
		
	}
}