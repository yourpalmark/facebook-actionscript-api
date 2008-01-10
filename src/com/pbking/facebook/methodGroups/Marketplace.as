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
	import com.pbking.facebook.data.marketplace.MarketplaceListing;
	import com.pbking.facebook.delegates.marketplace.CreateListing_delegate;
	import com.pbking.facebook.delegates.marketplace.GetCategories_delegate;
	import com.pbking.facebook.delegates.marketplace.GetListings_delegate;
	import com.pbking.facebook.delegates.marketplace.GetSubCategories_delegate;
	import com.pbking.facebook.delegates.marketplace.RemoveListing_delegate;
	import com.pbking.facebook.delegates.marketplace.SearchListings_delegate;
	
	public class Marketplace
	{
		// VARIABLES //////////
		
		// CONSTRUCTION //////////
		
		function Marketplace():void
		{
			//nothing here
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		public function createListing(listing:MarketplaceListing, show_on_profile:Boolean=true, callback:Function=null):CreateListing_delegate
		{
			var d:CreateListing_delegate = new CreateListing_delegate(listing, show_on_profile);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}
		
		public function removeListing(listing_id:int, callback:Function):RemoveListing_delegate
		{
			var d:RemoveListing_delegate = new RemoveListing_delegate(listing_id);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		public function getCategories(callback:Function=null):GetCategories_delegate
		{
			var d:GetCategories_delegate = new GetCategories_delegate();
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		public function getSubCategories(category:String, callback:Function=null):GetSubCategories_delegate
		{
			var d:GetSubCategories_delegate = new GetSubCategories_delegate(category);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		/**
		 * Return all Marketplace listings either by listing ID or by user. 
		 */
		public function getListings(listingIds:Array=null, users:Array=null, callback:Function=null):GetListings_delegate
		{
			var d:GetListings_delegate = new GetListings_delegate(listingIds, users);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

		/**
		 * Search Marketplace for listings filtering by category, subcategory, and a query string. 
		 * 
		 * @param category  string  Filter by a Marketplace category.  (While this parameter is optional, you must specify it if you want to filter by subcategory.)   
		 * @param subcategory  string  Filter by a Marketplace subcategory. (optional)   
 		 * @param query  string  Filter by a query string.  (optional)

		 */
		public function search(category:String="", subcategory:String="", query:String="", callback:Function=null):SearchListings_delegate
		{
			var d:SearchListings_delegate = new SearchListings_delegate(category, subcategory, query);
			MethodGroupUtil.addCallback(d, callback);
			return d;
		}

	}
}