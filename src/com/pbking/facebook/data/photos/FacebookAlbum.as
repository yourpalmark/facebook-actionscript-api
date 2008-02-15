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
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.facebook.delegates.photos.GetPhotosDelegate;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class FacebookAlbum extends EventDispatcher
	{
		// VARIABLES //////////
		
		//new props
		private var _cover:FacebookPhoto;
		private var _populated:Boolean = false;
		private var _populating:Boolean = false;
		private var _photos:Array = [];
		
		//facebook props
		private var _aid:String;
		private var _cover_pid:String;
		private var _owner:FacebookUser;
		private var _name:String;
		private var _created:Date;
		private var _modified:Date;
		private var _description:String;
		private var _location:String;
		private var _link:String;
		private var _size:int;
		
		// CONSTRUCTION //////////
		
		function FacebookAlbum(initObj:Object)
		{
			this._aid = initObj.aid;
			
			if(initObj.cover_pid)
				this._cover_pid = initObj.cover_pid;
				
			this._owner = FacebookUser.getUser(parseInt(initObj.owner));
			
			this._name = initObj.name;
			this._description = initObj.description;
			this._location = initObj.location;
			this._link = initObj.link;
			
			this._created = FacebookDataParser.formatDate(initObj.created);
			this._modified = FacebookDataParser.formatDate(initObj.modified);
			
			this._size = Number(initObj.size);

			if(this.size == 0)
				this._populated = true;
		}
		
		
		// GETTERS and SETTERS //////////
		
		public function get aid():String
		{
			return this._aid;
		}
		
		public function get cover_pid():String
		{
			return _cover_pid;
		}
		
		public function get owner():FacebookUser
		{
			return _owner;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get created():Date
		{
			return _created;
		}
		
		public function get modified():Date
		{
			return _modified;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		public function get location():String
		{
			return _location;
		}
		
		public function get link():String
		{
			return _link;
		}
		
		public function get size():int
		{
			return _size;
		}
		
		public function get cover():FacebookPhoto { return _cover; }
		public function set cover(newVal:FacebookPhoto):void
		{
			if(newVal.pid == this.cover_pid)
				_cover = newVal;
		}
		
		public function set populated(newVal:Boolean):void { this._populated = newVal; }
		public function get populated():Boolean { return _populated; }
		
		public function set photos(newVal:Array):void { this._photos = newVal;}
		public function get photos():Array { return _photos; }
		
		// PUBLIC FUNCTIONS //////////
		
		public function populate(facebookReference:Facebook):void
		{
			if(!_populating && !_populated)
			{
				_populating = true;
				facebookReference.photos.getPhotos(undefined, this.aid, undefined, onPopulationComplete);
			}
			else if(_populated)
			{
				dispatchEvent(new Event("populationComplete"));
			}
		}
		private function onPopulationComplete(event:Event):void
		{
			var delegate:GetPhotosDelegate = event.target as GetPhotosDelegate;
			this._photos = delegate.photos;
			
			_populating = false;
			_populated = true;
			
			dispatchEvent(new Event("populationComplete"));
		}
	}
}