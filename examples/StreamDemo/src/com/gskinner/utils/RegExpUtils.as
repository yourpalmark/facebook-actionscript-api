/**
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
* Copyright (c) 2009 Grant Skinner
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
**/
package com.gskinner.utils {
	
	public class RegExpUtils {
		
		protected static const FIND_URLS:RegExp = /((http|https):\/\/)?([a-z0-9_-]+(\.)[a-z0-9_-]+)(\.)([a-z]{2,4})([:\%-=#\?&,\.\/~a-z0-9]*)\b/ig;
		protected static const HAS_HTTP:RegExp = /http|https/ig;
		
		/*
		wdg:: Utility function to find links in an text block, and wrap them in href tags.
		*/
		public static function parseURLs(p_txt:String):String {
			FIND_URLS.lastIndex = 0;
			HAS_HTTP.lastIndex = 0;
			
            var r:Object = FIND_URLS.exec(p_txt);
            var returnStr:String = '';
            var lastIndex:Number = 0;
            
            while (r) {
                returnStr += p_txt.slice(lastIndex, r.index);
                var url:String = '<a class="url" href="event:' + ((HAS_HTTP.test(r[0]))?'':'http://') + r[0] + '">' + r[0] + '</a>';
                returnStr += url;
                lastIndex = r.index+r[0].length;
                r = FIND_URLS.exec(p_txt);
            }
            
            returnStr += p_txt.slice(lastIndex, p_txt.length);
            return returnStr;
  		 }

	}
}