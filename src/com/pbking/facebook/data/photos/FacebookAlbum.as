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
 *  Abstraction of the Facebook Album
 * 
 * @author Jason Crist 
 * @author Chris Hill
 */
package com.pbking.facebook.data.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.FacebookAsset;
	import com.pbking.facebook.delegates.photos.GetPhotos_delegate;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	[Bindable]
	public class FacebookAlbum extends FacebookAsset
	{
		// VARIABLES //////////
		
		private var _cover:FacebookPhoto;
		private var _populated:Boolean = false;
		private var _populating:Boolean = false;
		private var _photos:ArrayCollection;
		
		// CONSTRUCTION //////////
		
		function FacebookAlbum(xml:XML)
		{
			super(xml);
			
			if(this.size == 0)
			{
				this._photos = new ArrayCollection();
				this._populated = true;
			}
			
			default xml namespace = new Namespace("http://api.facebook.com/1.0/");

			if(xml.cover != undefined)
			{
				this._cover = new FacebookPhoto(xml.cover.photo[0]);
				delete xml.cover;
			}
			
			if(xml.photos != undefined)
			{
				var myPhotos:Array = [];
				var photosX:XMLList = xml.photos..photo;
				for each(var photoX:XML in photosX)
				{
					myPhotos.push(new FacebookPhoto(photoX));
				}
				this._photos = new ArrayCollection(myPhotos);
				this._populated = true;
				delete xml.photos;
			}
			
		}
		
		// GETTERS and SETTERS //////////
		
		public function set aid(s:String):void { /*for binding*/ }
		public function get aid():String
		{
			//return getXMLProperty("aid");
			default xml namespace = new Namespace("http://api.facebook.com/1.0/");
			return _xml.aid;
		}
		
		public function set cover_pid(s:String):void { /*for binding*/ }
		public function get cover_pid():String
		{
			return getXMLProperty("cover_pid");
		}
		
		public function set owner(s:String):void { /*for binding*/ }
		public function get owner():String
		{
			return getXMLProperty("owner");;
		}
		
		public function set name(s:String):void { /*for binding*/ }
		public function get name():String
		{
			return getXMLProperty("name");
		}
		
		public function set created(s:String):void { /*for binding*/ }
		public function get created():String
		{
			return getXMLProperty("created");
		}
		
		public function set modified(s:String):void { /*for binding*/ }
		public function get modified():String
		{
			return getXMLProperty("modified");
		}
		
		public function set description(s:String):void { /*for binding*/ }
		public function get description():String
		{
			return getXMLProperty("description");
		}
		
		public function set location(s:String):void { /*for binding*/ }
		public function get location():String
		{
			return getXMLProperty("location");
		}
		
		public function set link(s:String):void { /*for binding*/ }
		public function get link():String
		{
			return getXMLProperty("link");
		}
		
		public function set size(s:Number):void { /*for binding*/ }
		public function get size():Number
		{
			return getXMLPropertyNum("size");
		}
		
		public function get cover():FacebookPhoto { return _cover; }
		public function set cover(newVal:FacebookPhoto):void
		{
			if(newVal.pid == this.cover_pid)
				_cover = newVal;
		}
		
		public function set populated(newVal:Boolean):void { /*for binding*/}
		public function get populated():Boolean 
		{ 
			return _populated; 
		}
		
		public function set photos(newVal:ArrayCollection):void { /*for binding*/}
		public function get photos():ArrayCollection 
		{ 
			return _photos; 
		}
		
		// PUBLIC FUNCTIONS //////////
		
		public function populate(facebookReference:Facebook):void
		{
			if(!_populating && !_populated)
			{
				trace("populating: " + this.aid);
				_populating = true;
				facebookReference.photos.getPhotos(undefined, this.aid, undefined, onPopulationComplete);
			}
			else if(_populated)
			{
				dispatchEvent(new Event("populationComplete"));
			}
		}
		
		override public function serialize():XML
		{
			var myX:XML = _xml.copy();
			
			if(cover)
			{
				var coverx:XML = <cover/>;
				coverx.appendChild(cover.serialize());
				myX.appendChild(coverx);
			}
			
			if(populated)
			{
				var photosx:XML = <photos/>;
				for each(var photo:FacebookPhoto in photos)
				{
					photosx.appendChild(photo.serialize());
				}
				myX.appendChild(photosx);
			}
			
			return myX;
		}
		
		// PRIVATE FUNCTIONS //////////
		
		private function onPopulationComplete(event:Event):void
		{
			var delegate:GetPhotos_delegate = event.target as GetPhotos_delegate;
			this._photos = new ArrayCollection(delegate.photos);
			
			_populating = false;
			_populated = true;
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "populated", false, true));
			dispatchEvent(new Event("populationComplete"));
		}
	}
}