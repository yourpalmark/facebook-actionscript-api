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
 *  Abstraction of the Facebook Tag object
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.terralever.facebook.data.photos
{
	import com.terralever.facebook.data.FacebookAsset;
	
	/*
	  <photo_tag>
	    <pid>34995991612795</pid>
	    <subject>1240078</subject>
	    <xcoord>51.4901</xcoord>
	    <ycoord>23.6203</ycoord>
	  </photo_tag>
	*/	

	[Bindable]
	public class FacebookTag extends FacebookAsset
	{
		// CONSTRUCTION //////////
		
		function FacebookTag(xml:XML)
		{
			super(xml);
		}
		
		// GETTERS //////////
		
		public function get pid():int
		{
			return int(this.getXMLPropertyNum("pid"));
		}
		
		public function get subject():int
		{
			return int(this.getXMLPropertyNum("subject"));
		}
		
		public function get xcoord():Number
		{
			return this.getXMLPropertyNum("xcoord");
		}

		public function get ycoord():Number
		{
			return this.getXMLPropertyNum("ycoord");
		}

	}
}