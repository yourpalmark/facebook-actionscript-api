package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.photos.FacebookAlbum;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class CreateAlbumDelegate extends FacebookDelegate
	{
		public var newAlbum:FacebookAlbum;
		
		public function CreateAlbumDelegate(facebook:Facebook, name:String, location:String="", description:String="")
		{
			super(facebook);
			
			fbCall.setRequestArgument("name", name);

			if(location != "")
				fbCall.setRequestArgument("location", location);

			if(description != "")
				fbCall.setRequestArgument("description", description);

			fbCall.post("facebook.photos.createAlbum");
		}
		
		override protected function handleResult(result:Object):void
		{
			newAlbum = new FacebookAlbum(result);
		}
	}
}