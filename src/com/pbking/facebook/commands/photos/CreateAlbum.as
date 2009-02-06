package com.pbking.facebook.commands.photos
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.photos.FacebookAlbum;

	[Bindable]	
	public class CreateAlbum extends FacebookCall
	{
		public var name:String;
		public var location:String;
		public var description:String;
		
		public var newAlbum:FacebookAlbum;
		
		public function CreateAlbum(name:String=null, location:String="", description:String="")
		{
			super("facebook.photos.createAlbum");
			
			this.name = name;
			this.location = location;
			this.description = description;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			setRequestArgument("name", name);

			if(location != "")
				setRequestArgument("location", location);

			if(description != "")
				setRequestArgument("description", description);
		}
		
		override protected function handleSuccess(result:Object):void
		{
			newAlbum = new FacebookAlbum(result);
		}
	}
}