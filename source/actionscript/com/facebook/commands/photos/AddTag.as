/**
 * http://wiki.developers.facebook.com/index.php/Photos.addTag
 * Feb 16/09
 */
package com.facebook.commands.photos {
	
	import com.facebook.data.photos.PhotoTagCollection;
	import com.facebook.facebook_internal;
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;

	use namespace facebook_internal;

	/**
	 * The AddTag class represents the public  
      Facebook API known as Photos.addTag.
	 * @see http://wiki.developers.facebook.com/index.php/Photos.addTag
	 */
	public class AddTag extends FacebookCall {

		
		public static const METHOD_NAME:String = 'photos.addTag';
		public static const SCHEMA:Array = ['pid','tag_uid','tag_text','x','y','tags','owner_uid'];
		
		public var pid:String;
		public var tag_uid:String;
		public var tag_text:String;
		public var xPos:Number;
		public var yPos:Number;
		public var tags:PhotoTagCollection;
		public var owner_uid:String;
		
		public function AddTag(pid:String, tag_uid:String=null, tag_text:String=null, x:Number=NaN, y:Number=NaN, tags:PhotoTagCollection=null, owner_uid:String=null) {
			super(METHOD_NAME);
			if (tags == null && tag_uid==null && tag_text==null && isNaN(x) && isNaN(y)) {
				throw new Error("Please specify a tags array or all of [tag_uid, tag_text, x, y] ");
			}
			if (tags == null && ( tag_uid==null || tag_text==null || isNaN(x) || isNaN(y))) {
				throw new Error("When tags is null you must specify [tag_uid, tag_text, x, y]");
			}
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
			
			applySchema(SCHEMA, pid, tag_uid, tag_text, xPos, yPos, FacebookDataUtils.facebookCollectionToJSONArray(tags), owner_uid);
			super.facebook_internal::initialize();
		}
	}
}