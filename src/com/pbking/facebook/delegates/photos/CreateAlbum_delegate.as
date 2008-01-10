package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.photos.FacebookAlbum;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;

	public class CreateAlbum_delegate extends FacebookDelegate
	{
		public var newAlbum:FacebookAlbum;
		
		public function CreateAlbum_delegate(name:String, location:String="", description:String="")
		{
			fbCall.setRequestArgument("name", name);

			if(location != "")
				fbCall.setRequestArgument("location", location);

			if(description != "")
				fbCall.setRequestArgument("description", description);

			fbCall.post("facebook.photos.createAlbum");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			newAlbum = new FacebookAlbum(resultXML.toString());
		}
	}
}