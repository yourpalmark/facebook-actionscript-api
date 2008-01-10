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
 *  Abstraction of the Facebook Tag object
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.pbking.facebook.data.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	
	
	
	[Bindable]
	public class FacebookTag
	{
		// VARIABLES //////////
		
		private var _pid:int;
		private var _subject:FacebookUser;
		private var _xcoord:Number;
		private var _ycoord:Number;
		
		// CONSTRUCTION //////////
		
		function FacebookTag(xml:XML)
		{
			if(xml) parseXML(xml);
		}
		
		private function parseXML(xml:XML):void
		{
			/*
			  <photo_tag>
			    <pid>34995991612795</pid>
			    <subject>1240078</subject>
			    <xcoord>51.4901</xcoord>
			    <ycoord>23.6203</ycoord>
			  </photo_tag>
			*/	
			
			this._pid = parseInt(xml.pid);
			this._subject = Facebook.instance.getUser(parseInt(xml.subject));
			this._xcoord = Number(xml.xcoord);
			this._ycoord = Number(xml.ycoord);
		}
		
		// GETTERS //////////
		
		public function get pid():int
		{
			return this._pid
		}
		
		public function get subject():FacebookUser
		{
			return this._subject;
		}
		
		public function get xcoord():Number
		{
			return this._xcoord;
		}

		public function get ycoord():Number
		{
			return this._ycoord;
		}

	}
}