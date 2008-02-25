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

package com.pbking.facebook.methodGroups
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.pages.GetPageInfoDelegate;
	import com.pbking.facebook.delegates.pages.IsAdminDelegate;
	import com.pbking.facebook.delegates.pages.IsAppAddedDelegate;
	import com.pbking.facebook.delegates.pages.IsFanDelegate;
	
	public class Pages
	{
		// VARIABLES //////////
		
		private var facebook:Facebook;
		
		// CONSTRUCTION //////////
		
		function Pages(facebook:Facebook):void
		{
			this.facebook = facebook;
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		public function isAppAdded(page_id:Number, callback:Function=null):IsAppAddedDelegate
		{
			var d:IsAppAddedDelegate = new IsAppAddedDelegate(facebook, page_id);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		public function isAdmin(page_id:Number, callback:Function):IsAdminDelegate
		{
			var d:IsAdminDelegate = new IsAdminDelegate(facebook, page_id);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		public function isFan(page_id:Number, uid:String=null, callback:Function=null):IsFanDelegate
		{
			var d:IsFanDelegate = new IsFanDelegate(facebook, page_id, uid);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		public function getInfo(fields:Array, page_ids:Array=null, uid:String=null, type:String=null, callback:Function=null):GetPageInfoDelegate
		{
			var d:GetPageInfoDelegate = new GetPageInfoDelegate(facebook, fields, page_ids, uid, type);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

	}
}