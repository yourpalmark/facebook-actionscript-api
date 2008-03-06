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
 *  Abstraction of the Facebook Photo object
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.data.photos
{
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	
	[Bindable]
	public class FacebookPhoto
	{
		// VARIABLES //////////
		
		public var pid:String;
		public var aid:String;
		public var owner:FacebookUser;
		public var src:String;
		public var src_big:String;
		public var src_small:String;
		public var link:String;
		public var caption:String;
		public var created:Date;

		public var tags:Array = [];
	
		// CONSTRUCTION //////////
		
		function FacebookPhoto(initObj:Object)
		{
		  	this.pid = initObj.pid;
		  	this.aid = initObj.aid;
		  	this.owner = FacebookUser.getUser(initObj.owner);
		  	this.src = initObj.src;
		  	this.src_big = initObj.src_big;
		  	this.src_small = initObj.src_small;
		  	this.link = initObj.link;
		  	this.caption = initObj.caption;
		  	this.created = FacebookDataParser.formatDate(initObj.created);
		}
		
		// GETTERS //////////
		
	}
}