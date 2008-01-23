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
 *  Delegates the call to facebook.photo.getAlbums
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.data.photos.FacebookAlbum;
	import com.pbking.facebook.data.photos.FacebookPhoto;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	import flash.events.Event;
	
	public class GetAlbums_delegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		//results
		
		public var albums:Array;
		
		private var doGetCovers:Boolean;
		private var doGetImages:Boolean;
		
		// CONSTRUCTION //////////
		
		public function GetAlbums_delegate(user:FacebookUser, doGetCovers:Boolean = false, doGetImages:Boolean = false)
		{
			PBLogger.getLogger("pbking.facebook").debug("getting all albums for user: " + user.uid);
			
			this.doGetCovers = doGetCovers;
			this.doGetImages = doGetImages;
			
			fbCall.setRequestArgument("uid", user.uid.toString());
			fbCall.post("facebook.photos.getAlbums");
		}
		
		override protected function result(e:Event):void
		{
			//since we're handling the result ourselves, we must
			//do all the things the super did like event removal
			//and error handling
			
			fbCall.removeEventListener(Event.COMPLETE, result);

			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			//look for an error
			if(fbCall.getResponse().error_code != undefined)
			{
				//dang.  handle the error
				this.errorCode = fbCall.getResponse().error_code;
				this.errorMessage = fbCall.getResponse().error_msg;
				onError();
			}
			
			else
			{
				albums = [];
				
				var xAlbums:XMLList = fbCall.getResponse()..album;
				for each(var xAlbum:XML in xAlbums)
				{
					var album:FacebookAlbum = new FacebookAlbum(xAlbum);
					albums.push(album);
				} 
				
				//first we get the covers then the images
				if(doGetCovers)
					this.getCovers();
	
				else if(doGetImages)
					this.getImages();
	
				else
					this.onComplete();
			}
		}
		
		private function getCovers():void
		{
			var cover_pids:Array = new Array();
			for each(var album:FacebookAlbum in albums)
			{
				cover_pids.push(album.cover_pid);
			}
			
			fBook.photos.getPhotos(undefined, undefined, cover_pids, onGotCovers );
		}
		
		private function onGotCovers(event:Event):void
		{
			var d:GetPhotos_delegate = event.target as GetPhotos_delegate;
			
			if(d.success)
			{
				for each(var photo:FacebookPhoto in d.photos)
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
				}
			}
		}
		
		private function onAlbumPopulationComplete(event:Event):void
		{
			var eventAlbum:FacebookAlbum = event.target as FacebookAlbum;
			eventAlbum.removeEventListener("populationComplete", onAlbumPopulationComplete);

			//check all the albums to see if they're populated
			for each(var album:FacebookAlbum in albums)
			{
				if(!album.populated)
				{
					return;
				}
			}

			this.onComplete();
		}
	}
}