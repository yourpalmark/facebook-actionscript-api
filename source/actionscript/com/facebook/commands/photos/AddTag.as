/**
 * http://wiki.developers.facebook.com/index.php/Photos.addTag
 * Feb 16/09
 */
package com.facebook.commands.photos {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The AddTag class represents the public  
      Facebook API known as Photos.addTag.
	 * @see http://wiki.developers.facebook.com/index.php/Photos.addTag
	 */
	public class AddTag extends FacebookCall {

		
		public static var METHOD_NAME:String = 'photos.addTag';
		public static var SCHEMA:Array = ['pid','tag_uid','tag_text','x','y','tags','owner_uid'];
		
		public var pid:String;
		public var tag_uid:String;
		public var tag_text:String;
		public var xPos:Number;
		public var yPos:Number;
		public var tags:Array;
		public var owner_uid:String;
		
		public function AddTag(pid:String, tag_uid:String, tag_text:String, x:Number, y:Number, tags:Array=null, owner_uid:String=null) {
			super(METHOD_NAME);
			
			this.pid = pid;
			this.tag_uid = tag_uid;
			this.tag_text = tag_text;
			this.xPos = x;
			this.yPos = y;
			this.tags = tags;
			//this.tags = JSON.encode(tags as Object);
			this.owner_uid = owner_uid;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, pid, tag_uid, tag_text, xPos, yPos, JSON.encode(tags), owner_uid);
			super.facebook_internal::initialize();
		}
	}
}