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
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.profile.GetFBML_delegate;
	import com.pbking.facebook.delegates.profile.SetFBML_delegate;
	
	public class Profile
	{
		// VARIABLES //////////
		
		// CONSTRUCTION //////////
		
		function Profile():void
		{
			//nothing here
		}
		
		// FACEBOOK FUNCTION CALLS //////////
		
		/**
		 * Sets the FBML for a user's profile, including the content for both the profile box and the profile actions. 
		 * See the FBML documentation for a description of the markup and its role in various contexts. 
		 * Note that this method can also be used to set fb:profile-actions for users.
		 * 
		 * @param markup:String - The FBML that will be posted to the user's profile
		 * @param [user:FacebookUser] - The user whose profile is to be updated. 
		 * If not specified, defaults to the logged-in user. 
		 * Not allowed for desktop applications (since the application secret is essentially public).
		 */
		public function setFBML(markup:String, user:FacebookUser=null, callback:Function=null):SetFBML_delegate
		{
			var delegate:SetFBML_delegate = new SetFBML_delegate(markup, user);
			return MethodGroupUtil.addCallback(delegate, callback) as SetFBML_delegate;		
		}

		/**
		 * 
		 * @param [user:FacebookUser] - The user whose profile FBML is to be fetched. 
		 * If not specified, defaults to the logged-in user. 
		 * Not allowed for desktop applications (since the application secret is essentially public).
		 */
		public function getFBML(user:FacebookUser=null, callback:Function=null):GetFBML_delegate
		{
			var delegate:GetFBML_delegate = new GetFBML_delegate(user);
			return MethodGroupUtil.addCallback(delegate, callback) as GetFBML_delegate;		
		}

	}
}