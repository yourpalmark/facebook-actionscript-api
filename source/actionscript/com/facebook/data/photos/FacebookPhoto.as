/**
 * http://wiki.developers.facebook.com/index.php/Photos.upload#Example_Request
 * Feb 12/09
 */
package com.facebook.data.photos {
	
	import com.facebook.data.FacebookData;
	import com.facebook.data.users.FacebookUser;
	

	[Bindable]
	public class FacebookPhoto extends FacebookData {

		

		public var pid:String;

		public var aid:String;

		public var owner:Number;

		public var src:String;

		public var src_big:String;

		public var src_small:String;

		public var link:String;

		public var caption:String;

		public var created:Date;



		public var tags:Array;
		
		public function FacebookPhoto() {
			tags = [];
			super();

		}

		

	}

}