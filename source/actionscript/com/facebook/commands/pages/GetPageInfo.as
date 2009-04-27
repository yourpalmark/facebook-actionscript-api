/**
 * http://wiki.developers.facebook.com/index.php/Pages.getInfo
 * Feb 13/09
 * BUG with this API Call
 * Feb 13/09
 * BUG# 4373
 * http://bugs.developers.facebook.com/show_bug.cgi?id=4373
 */
package com.facebook.commands.pages {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.utils.FacebookDataUtils;
	import com.facebook.facebook_internal;

	use namespace facebook_internal;

	/**
	 * The GetPageInfo class represents the public  
      Facebook API known as Pages.getInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Pages.getInfo
	 */
	public class GetPageInfo extends FacebookCall {

		
		public static const METHOD_NAME:String = 'pages.getInfo';
		public static const SCHEMA:Array = ['fields', 'page_ids','uid','type'];
		
		public var fields:Array;
		public var page_ids:Array;
		public var uid:String;
		public var type:String;
		
		public var pages:Array;
		
		public function GetPageInfo(fields:Array, page_ids:Array=null, uid:String=null, type:String=null) {
			super(METHOD_NAME);
			
			this.fields = fields;
			this.page_ids = page_ids;
			this.uid = uid;
			this.type = type;
		}
		
		override facebook_internal function initialize():void {
			applySchema(SCHEMA, FacebookDataUtils.toArrayString(fields), FacebookDataUtils.toArrayString(page_ids), uid, type);
			super.facebook_internal::initialize();
		}
	}
}