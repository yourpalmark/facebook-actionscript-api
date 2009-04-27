package com.facebook.utils {
	import com.facebook.data.photos.AlbumCollection;
	import com.facebook.data.photos.AlbumData;
	
	import flash.net.URLVariables;
	
	
	public class FacebookXMLParserUtils {
		
		public static function toArray(value:XML):Array {
			if (value == null) { return null; }
			return value.toString().split(',');
		}
		
		public static function toNumber(value:XML):Number{
			if (value == null) { return NaN; }
			return Number(value.toString());
		}
		
		public static function toStringValue(value:XML):String {
			if (value == null) { return null; }
			return value.toString();
		}
		
		public static function toDate(value:String):Date {
			if (value == null) { return null; }
			var startDate:String = value;
			while (startDate.length < 13) { startDate = startDate + '0'; }
			
			var newDate:Date = new Date(Number(startDate));
			return newDate;
		}
		
		public static function toBoolean(value:XML):Boolean {
			if (value == null) { return false; } 
			return value.toString() == '1';
		}
		
		public static function toUIDArray(xml:XML):Array {
			var arr:Array =  [];
			if (xml == null) { return arr; }
			
			var uids:XMLList = xml.children();
			var l:uint = uids.length();
			
			for (var i:uint = 0;i<l;i++) {
				arr.push(toNumber(uids[i]));
			}
			
			return arr;
		}
		
		public static function xmlToUrlVariables(p_xml:XMLList):URLVariables {
			var vars:URLVariables = new URLVariables();
			
			for each(var xml:XML in p_xml) {
				vars[xml.key.valueOf()] = xml.value.valueOf(); 
			}
			
			return vars;
		}
		
		public static function nodeToObject(p_xml:XMLList):Object {
			var vars:Object = {};
			
			for each(var xml:XML in p_xml) {
				vars[xml.key.valueOf()] = xml.value.valueOf(); 
			}
			
			return vars;
		}
		
		public static function createAlbumCollection(xml:XML, ns:Namespace):AlbumCollection {
			var albumCollection:AlbumCollection = new AlbumCollection();
			for each(var singleAlbum:* in xml..ns::album) {
				var albumData:AlbumData = new AlbumData();
				albumData.aid = FacebookXMLParserUtils.toStringValue(singleAlbum.ns::aid[0]);
				albumData.cover_pid = FacebookXMLParserUtils.toStringValue(singleAlbum.ns::cover_pid[0]);
				albumData.owner = singleAlbum.ns::owner;
				albumData.name = singleAlbum.ns::name;
				albumData.created = FacebookXMLParserUtils.toDate(singleAlbum.ns::created);
				albumData.modified = FacebookXMLParserUtils.toDate(singleAlbum.ns::modified);
				albumData.description = singleAlbum.ns::description;
				albumData.location = singleAlbum.ns::location;
				albumData.link = singleAlbum.ns::link;
				albumData.size = singleAlbum.ns::size;
				albumData.visible = singleAlbum.ns::visible;
				albumCollection.addAlbum(albumData);
			}
			
			return albumCollection;
		}
		
	}
}