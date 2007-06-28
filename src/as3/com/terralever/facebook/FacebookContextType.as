/*
Copyright (c) 2007 Terralever

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

/**
 * The type of widget session the application is in when installed on the Facebook site.
 * Options are narrow, wide, and application.  If NOT currently on the site, it defaults to application.
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.terralever.facebook
{
	public class FacebookContextType
	{
		public static const NARROW:String = "narrow";
		public static const WIDE:String = "wide";
		public static const APPLICATION:String = "application";
		
		public static function check(value:String):Boolean
		{
			if(value == NARROW || value == WIDE || value == APPLICATION)
				return true;
			else
				return false;
		}
	}
}