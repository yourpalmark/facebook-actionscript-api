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