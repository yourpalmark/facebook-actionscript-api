/**
 *  Delegates call to facebook.photo.getTags
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.commands.photos
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.photos.NewTag;
		
	[Bindable]	
	public class AddTags extends FacebookCall
	{
		public var tags:Array;

		function AddTags(tags:Array=null)
		{
			super("facebook.photos.addTag");

			this.tags = tags;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			var tagsStrings:Array = [];
			
			for each(var newTag:NewTag in tags)
				tagsStrings.push(newTag.toString());
			
			var  tagsString:String = "[" + tagsStrings.join(",") + "]";
			
			setRequestArgument("tags", tagsString);
		}

	}
}