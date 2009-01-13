/**
 *  Delegates the call to facebook.photo.getAlbums
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.photos.FacebookAlbum;
	import com.pbking.facebook.data.photos.FacebookPhoto;
	
	import flash.events.Event;
	
	public class GetAlbums extends FacebookCall
	{
		// VARIABLES //////////
		
		public var uid:String;
		public var doGetCovers:Boolean;
		public var doGetImages:Boolean;

		public var albums:Array;
		
		
		// CONSTRUCTION //////////
		
		public function GetAlbums(uid:String=null, doGetCovers:Boolean=false, doGetImages:Boolean=false)
		{
			super("facebook.photos.getAlbums");
			
			this.uid = uid;
			this.doGetCovers = doGetCovers;
			this.doGetImages = doGetImages;
			
			this.repressOnComplete = true;
		}
		
		override public function initialize():void
		{
			fbCall.setRequestArgument("uid", uid.toString());
		}
		
		override public function handleSuccess(result:Object):void
		{
			albums = [];
			
			for each(var album:Object in result)
			{
				albums.push(new FacebookAlbum(album));
			} 
				
			//first we get the covers then the images
			if(doGetCovers)
				this.getCovers();

			else if(doGetImages)
				this.getImages();

			else
				this.onComplete();
		}
		
		override protected function handleException(exception:Object):void
		{
			onComplete();
		}
		
		private function getCovers():void
		{
			var cover_pids:Array = new Array();
			for each(var album:FacebookAlbum in albums)
			{
				cover_pids.push(album.cover_pid);
			}
			
			this.facebook.post(new GetPhotos(null, null, cover_pids), onGotCovers);
		}
		
		private function onGotCovers(var call:GetPhotos):void
		{
			if(call.success)
			{
				for each(var photo:FacebookPhoto in call.photos)
				{
					for each(var album:FacebookAlbum in albums)
					{
						if(album.cover_pid == photo.pid)
						{
							album.cover = photo;
							break;
						}
					}
				}
			}

			if(doGetImages)
				this.getImages();

			else
				this.onComplete();
		}
		
		private function getImages():void
		{
			for each(var album:FacebookAlbum in albums)
			{
				if(!album.populated)
				{
					album.addEventListener("populationComplete", onAlbumPopulationComplete);
					album.populate(this.facebook);
				}
			}
		}
		
		private function onAlbumPopulationComplete(event:Event):void
		{
			var eventAlbum:FacebookAlbum = event.target as FacebookAlbum;
			eventAlbum.removeEventListener("populationComplete", onAlbumPopulationComplete);

			this.onComplete();
		}
	}
}