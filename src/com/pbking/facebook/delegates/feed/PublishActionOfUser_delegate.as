package com.pbking.facebook.delegates.feed
{
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.facebook.Facebook;

	public class PublishActionOfUser_delegate extends FacebookDelegate
	{
		public function PublishActionOfUser_delegate(titleMarkup:String, bodyMarkup:String="", 
													image_1:String="", image_1_link:String="",
													image_2:String="", image_2_link:String="",
													image_3:String="", image_3_link:String="",
													image_4:String="", image_4_link:String="")
		{
			fbCall.setRequestArgument("title", titleMarkup);
			
			if(bodyMarkup != "") fbCall.setRequestArgument("body", bodyMarkup);
			
			if(image_1 != "") fbCall.setRequestArgument("image_1", image_1);
			if(image_1_link != "") fbCall.setRequestArgument("image_1_link", image_1_link);
			
			if(image_2 != "") fbCall.setRequestArgument("image_2", image_2);
			if(image_2_link != "") fbCall.setRequestArgument("image_2_link", image_2_link);
			
			if(image_3 != "") fbCall.setRequestArgument("image_3", image_3);
			if(image_3_link != "") fbCall.setRequestArgument("image_3_link", image_3_link);
			
			if(image_4 != "") fbCall.setRequestArgument("image_3", image_3);
			if(image_4_link != "") fbCall.setRequestArgument("image_3_link", image_3_link);
			
			fbCall.post("facebook.feed.publishActionOfUser");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			super.handleResult(resultXML);
			
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			success = parseInt(resultXML) == 1;
		}
		
	}
}