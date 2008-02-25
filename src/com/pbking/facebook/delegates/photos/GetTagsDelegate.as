/**
 *  Delegates call to facebook.photo.getTags
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.photos.FacebookPhoto;
	import com.pbking.facebook.data.photos.FacebookTag;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.collection.HashableArray;
		
	public class GetTagsDelegate extends FacebookDelegate
	{
		public var photos:Array;
		public var tags:Array;

		private var photoCollection:HashableArray = new HashableArray('pid', false);
		
		function GetTagsDelegate(facebook:Facebook, photos:Array)
		{
			super(facebook);
			
			this.photos = photos;
			
			var pids:Array = [];
			for(var i:int=0; i<photos.length; i++)
			{
				if(photos[i] is FacebookPhoto)
				{
					pids.push(photos[i].pid);
					photoCollection.addItem(photos[i]);
				}
				else
				{
					pids.push(photos[i]);
				}
			}
				
			fbCall.setRequestArgument("photos", pids.join(","));
			fbCall.post("facebook.photos.getTags");
		}

		override protected function handleResult(result:Object):void
		{
			//create all of the tag objects
			this.tags = [];
			for each(var tagInit:Object in result)
				this.tags.push(new FacebookTag(tagInit));

			if(photoCollection.length > 0)
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
				
				//now (re)populate the tags in the images
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