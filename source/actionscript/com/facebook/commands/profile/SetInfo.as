/**
 * 
 * http://wiki.developers.facebook.com/index.php/Profile.setInfo
 * Feb 19 / 09
 */ 
package com.facebook.commands.profile {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.profile.InfoFieldsData;
	import com.facebook.data.profile.InfoItemData;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;

	use namespace facebook_internal;

	/**
	 * The SetInfo class represents the public  
      Facebook API known as Profile.setInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Profile.setInfo
	 */
	public class SetInfo extends FacebookCall {

		
		public static var METHOD_NAME:String = 'profile.setInfo';
		public static var SCHEMA:Array = ['title','type','items','uid','format'];
		
		public var title:String;
		public var type:Number;
		public var items:InfoFieldsData;
		public var uid:String;
		public var format:String;
		
		public function SetInfo(title:String, type:Number, items:InfoFieldsData, uid:String, format:String = null) {
			super(METHOD_NAME);
			
			this.title = title;
			this.type = type;
			this.items = items;
			this.uid = uid;
			this.format = format;
		}
		
		override facebook_internal function initialize():void {
			var o:Object = {items:[], field:items.field};
			var l:Number = items.items.length;
			for(var i:Number =0; i< l; i++) {
				var item:InfoItemData = items.items.getItemAt(i) as InfoItemData;
				
				var value:Object = {};
				for each(var n:Object in item.schema) {
					if (item[n] == null) { continue; }
					value[n] = item[n];
				}
				o.items.push(value);
			}
			
			applySchema(SCHEMA, title, type, JSON.encode(o), uid, format);
			super.facebook_internal::initialize();
		}
		
	}
}