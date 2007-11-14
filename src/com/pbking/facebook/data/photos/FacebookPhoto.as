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
 * @author Chris Hill
 */
package com.pbking.facebook.data.photos
{
	import com.pbking.facebook.Facebook;
	import mx.logging.Log;
	import com.pbking.facebook.data.FacebookAsset;
	
	/*
	 <photo>
	    <pid>34585991612804</pid>
	    <aid>34585963571485</aid>
	    <owner>1240077</owner>
	    <src>http://ip002.facebook.com/v11/135/18/8055/s1240077_30043524_2020.jpg</src>
	    <src_big>http://ip002.facebook.com/v11/135/18/8055/n1240077_30043524_2020.jpg</src>
	    <src_small>http://ip002.facebook.com/v11/135/18/8055/t1240077_30043524_2020.jpg</src>
	    <link>http://www.facebook.com/photo.php?pid=30043524&id=8055</link>
	    <caption>From The Deathmatch (Trailer) (1999)</caption>
	    <created>1132553361</created>
	 </photo>
  	*/
	
	[Bindable]
	public class FacebookPhoto extends FacebookAsset
	{
	
		// CONSTRUCTION //////////
		
		function FacebookPhoto(xml:XML)
		{
			super(xml);
		}
		
		// GETTERS //////////
		
		public function set pid(o:String):void { /*for binding*/ }
		public function get pid():String
		{
			return getXMLProperty("pid");
		}
		
		public function set aid(o:String):void { /*for binding*/ }
		public function get aid():String
		{
			return getXMLProperty("aid");
		}
		
		public function set owner(o:String):void { /*for binding*/ }
		public function get owner():String
		{
			return getXMLProperty("owner");
		}
		
		public function set src(o:String):void { /*for binding*/ }
		public function get src():String
		{
			return getXMLProperty("src");
		}
		
		public function set src_big(o:String):void { /*for binding*/ }
		public function get src_big():String
		{
			return getXMLProperty("src_big");
		}
		
		public function set src_small(o:String):void { /*for binding*/ }
		public function get src_small():String
		{
			return getXMLProperty("src_small");
		}
		
		public function set link(o:String):void { /*for binding*/ }
		public function get link():String
		{
			return getXMLProperty("link");
		}
		
		public function set caption(o:String):void { /*for binding*/ }
		public function get caption():String
		{
			return getXMLProperty("caption");
		}
		
		public function set created(o:Number):void { /*for binding*/ }
		public function get created():Number
		{
			return getXMLPropertyNum("created");
		}
		
	}
}