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
		
		public function CreateAlbum_delegate(fBook:Facebook, name:String, location:String="", description:String="")
		{
			super(fBook);

			var fbCall:FacebookCall = new FacebookCall(fBook);

			fbCall.addEventListener(Event.COMPLETE, result);

			fbCall.setRequestArgument("name", name);

			if(location != "")
				fbCall.setRequestArgument("location", location);

			if(description != "")
				fbCall.setRequestArgument("description", description);

			fbCall.post("facebook.photos.createAlbum");
		}
		
		override protected function result(event:Event):void
		{
			var fbCall:FacebookCall = event.target as FacebookCall;

			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			newAlbum = new FacebookAlbum(fbCall.getResponse());
			
			this.onComplete();
		}
	}
}