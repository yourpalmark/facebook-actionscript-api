/*
Copyright (c) 2007 Jason Crist

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
 *  Delegates call to facebook.photo.getTags
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;
		
	public class GetTags_delegate extends FacebookDelegate
	{
		function GetTags_delegate(fBook:Facebook, tags:Array)
		{
			super(fBook);
			//construct the tags string to look something like this:
			// [{"x":"30.0","y":"30.0","uid":1234567890} , {"x":"70.0","y":"70.0","text":"some person"}]
			
			var objs:Array = [];
			for each(var o:Object in tags)
			{
				var props:Array = [];
				for(var i:String in o)
				{
					if(o[i] != null)
						props.push('"' + i + '"' + ':' + '"' + o[i] + '"');
				}
				objs.push('{' + props.join(",") + '}');
			}
			
			var tagString:String = '[' + objs.join(',') + ']';

			//TODO: make the call, form the response

		}
	}
}