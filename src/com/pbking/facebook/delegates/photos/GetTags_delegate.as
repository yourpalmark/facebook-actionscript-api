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
 *  Delegates call to facebook.photo.getTags
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.data.photos.FacebookPhoto;
	import com.pbking.facebook.data.photos.FacebookTag;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.collection.HashableArray;
		
	public class GetTags_delegate extends FacebookDelegate
	{
		public var photos:Array;
		public var tags:Array;
		public var populatePhotosWithTags:Boolean;

		private var photoCollection:HashableArray = new HashableArray('pid', false);
		
		function GetTags_delegate(photos:Array, populatePhotosWithTags:Boolean = true)
		{
			this.photos = photos;
			this.populatePhotosWithTags = populatePhotosWithTags;
			
			var pids:Array = [];
			for each(var photo:FacebookPhoto in photos)
			{
				pids.push(photo.pid);
				photoCollection.addItem(photo);
			}
				
			fbCall.setRequestArgument("photos", pids.join(","));
			fbCall.post("facebook.photos.getTags");
		}

		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			var xTags:XMLList = resultXML..photo_tag;
			
			//create all of the tag objects
			this.tags = [];
			for each(var xTag:XML in xTags)
				this.tags.push(new FacebookTag(xTag));

			if(populatePhotosWithTags)
			{
				var tag:FacebookTag;
				var photo:FacebookPhoto;
				
				//first clear all of the tags for the images we got tags for
				for each(tag in tags)
				{
					photo = photoCollection.getItemById(tag.pid) as FacebookPhoto;
					if(photo)
						photo.tags.removeAll();
				}
				
				//not (re)populate the tags in the images
				for each(tag in tags)
				{
					photo = photoCollection.getItemById(tag.pid) as FacebookPhoto;
					if(photo)
						photo.tags.addItem(tag);
				} 
			}			
		}
	}
}