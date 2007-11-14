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

package com.pbking.facebook.methodGroups
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.photos.FacebookAlbum;
	import com.pbking.facebook.delegates.photos.*;
	
	import flash.events.Event;
	
	public class Photos
	{
		private var facebook:Facebook
		
		function Photos(facebook:Facebook):void
		{
			this.facebook = facebook;
		}
		
		// FACEBOOK FUNCTIONS //////////
		
		public function createAlbum(name:String, location:String, description:String, callback:Function = null):void
		{
			//TODO: createAlbum
		}
		
		public function getTags(photos:Array, callback:Function = null):void
		{
			//TODO: getTags
		}
		
		public function upload(album:FacebookAlbum, caption:String, data:*, callback:Function = null):void
		{
			//TODO: upload
		}
		
		/**
		 * Adds a tag with the given information to a photo.
		 */
		public function addTag(pid:int, tag_uid:int, tag_text:String, x:Number, y:Number, callback:Function=null):GetTags_delegate
		{
			return addTags([{pid:int, tag_uid:tag_uid, tag_text:tag_text, x:x, y:y}], callback);
		}
		
		/**
		 * Add multiple tags.  Each item in the array must have:
		 * pid, tag_uid OR tag_text, x, y
		 */
		public function addTags(tags:Array, callback:Function = null):GetTags_delegate
		{
			var delegate:GetTags_delegate = new GetTags_delegate(facebook, tags);
			
			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);
				
			return delegate;
		}
		
		public function getAlbums(uid:String, callback:Function = null, getCoverPhotos:Boolean = false):GetAlbums_delegate
		{
			var delegate:GetAlbums_delegate = new GetAlbums_delegate(facebook, uid, getCoverPhotos);
			
			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);
				
			return delegate;
		}
		
		public function getPhotos(subj_id:Object, aid:Object, pids:Array, callback:Function = null):GetPhotos_delegate
		{
			var delegate:GetPhotos_delegate = new GetPhotos_delegate(facebook, subj_id, aid, pids);
			
			if(callback != null)
				delegate.addEventListener(Event.COMPLETE, callback);
				
			return delegate;
		}
		
		// HELPER FUNCTIONS //////////

		public function getPhotosForAlbum(album:FacebookAlbum, callback:Function = null):GetPhotos_delegate
		{
			return getPhotos(null, album.aid, null, callback);
		}
		
	}
}