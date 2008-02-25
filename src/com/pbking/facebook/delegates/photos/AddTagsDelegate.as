/**
 *  Delegates call to facebook.photo.getTags
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.photos.NewTag;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.collection.HashableArray;
		
	public class AddTagsDelegate extends FacebookDelegate
	{
		public var newTags:Array;

		private var photoCollection:HashableArray = new HashableArray('pid', false);
		
		function AddTagsDelegate(facebook:Facebook, newTags:Array)
		{
			super(facebook);
			
			this.newTags = newTags;
			
			var tagsStrings:Array = [];
			for each(var newTag:NewTag in newTags)
				tagsStrings.push(newTag.toString());
			
			var  tagsString:String = "[" + tagsStrings.join(",") + "]";
			
			fbCall.setRequestArgument("tags", tagsString);
			fbCall.post("facebook.photos.addTag");
		}

		override protected function handleResult(result:Object):void
		{
			this.success = Boolean(result);
		}
	}
}