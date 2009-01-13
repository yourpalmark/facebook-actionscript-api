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
 *  Delegates the call to facebook.photo.upload
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.photos.FacebookPhoto;
	
	import flash.utils.ByteArray;
	
	public class UploadPhoto extends FacebookCall
	{
		// VARIABLES //////////
		
		public var data:ByteArray;
		public var aid:String;
		public var caption:String;
		
		public var uploadedPhoto:FacebookPhoto;
		
		// CONSTRUCTION //////////
		
		public function UploadPhoto(data:ByteArray=null, aid:String=null, caption:String=null)
		{
			super("facebook.photos.upload");
			
			this.data = data;
			this.aid = aid;
			this.caption = caption;
			
			//TODO: Fix Upload Photo in environments that use JavaScript to communicate with the API
			//The IFacebookCallDelegate classes will likely also need to be involved with this fix.
			throw new Error(":(  Unfortunately, the UploadPhoto command doesn't work in most situations and is currently depreciated.");
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			setRequestArgument("data", data);
			
			if(aid != null)
				setRequestArgument("aid", aid);
				
			if(caption != null && caption != "")
				setRequestArgument("caption", caption);
		}

		// RESULT //////////

		override protected function handleResult(result:Object):void
		{
			uploadedPhoto = new FacebookPhoto(result);
		}
	}
}