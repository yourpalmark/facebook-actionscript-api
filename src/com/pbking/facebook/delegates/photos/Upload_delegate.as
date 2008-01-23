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
	import com.pbking.facebook.data.photos.FacebookAlbum;
	import com.pbking.facebook.data.photos.FacebookPhoto;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	import flash.utils.ByteArray;
	
	public class Upload_delegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		public var uploadedPhoto:FacebookPhoto;
		
		// CONSTRUCTION //////////
		
		public function Upload_delegate(data:ByteArray, album:FacebookAlbum=null, caption:String="")
		{
			PBLogger.getLogger("pbking.facebook").debug("uploading an image");
			
			fbCall.setRequestArgument("data", data);
			if(album != null)
				fbCall.setRequestArgument("aid", album.aid.toString());
			if(caption != "")
				fbCall.setRequestArgument("caption", caption);

			fbCall.post("facebook.photos.upload");
		}

		// RESULT //////////

		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			uploadedPhoto = new FacebookPhoto(resultXML);
		}
	}
}