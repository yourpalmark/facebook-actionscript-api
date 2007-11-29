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
 *  Base class for all facebook object abstractions
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.pbking.facebook.data
{
	import flash.events.EventDispatcher;

	[Bindable]
	public class FacebookAsset extends EventDispatcher
	{
		
		protected var _xml:XML;
		
		public function FacebookAsset(xml:XML)
		{
			_xml = xml;
		}
		
		public function serialize():XML
		{
			return new XML(_xml);
		}
		
		protected function getXMLProperty(prop:String):String{
			//default xml namespace = Facebook.getInstance().FACEBOOK_NAMESPACE;
			default xml namespace = new Namespace("http://api.facebook.com/1.0/");
			return _xml.descendants(prop);
		}
		
		protected function getXMLPropertyNum(prop:String):Number{
			var val:String = getXMLProperty(prop);
			return Number(val);
		}
	}
}
