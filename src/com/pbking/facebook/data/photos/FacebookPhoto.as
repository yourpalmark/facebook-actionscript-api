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
		
		private var _pid:String;
		private var _aid:String;
		private var _owner:FacebookUser;
		private var _src:String;
		private var _src_big:String;
		private var _src_small:String;
		private var _link:String;
		private var _caption:String;
		private var _created:Date;

		private var _tags:Array = [];
	
		// CONSTRUCTION //////////
		
		function FacebookPhoto(initObj:Object)
		{
		  	this._pid = initObj.pid;
		  	this._aid = initObj.aid;
		  	this._owner = FacebookUser.getUser(initObj.owner);
		  	this._src = initObj.src;
		  	this._src_big = initObj.src_big;
		  	this._src_small = initObj.src_small;
		  	this._link = initObj.link;
		  	this._caption = initObj.caption;
		  	this._created = FacebookDataParser.formatDate(initObj.created);
		}
		
		// GETTERS //////////
		
		public function get pid():String
		{
			return _pid;
		}
		
		public function get aid():String
		{
			return _aid
		}
		
		public function get owner():FacebookUser
		{
			return _owner;
		}
		
		public function get src():String
		{
			return _src
		}
		
		public function get src_big():String
		{
			return _src_big;
		}
		
		public function get src_small():String
		{
			return _src_small;
		}
		
		public function get link():String
		{
			return _link;
		}
		
		public function get caption():String
		{
			return _caption;
		}
		
		public function get created():Date
		{
			return _created;
		}
		
		public function get tags():Array
		{
			return _tags;
		}
		
	}
}