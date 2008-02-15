package com.pbking.facebook.delegates.feed
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class PublishTemplatizedActionDelegate extends FacebookDelegate
	{
		public function PublishTemplatizedActionDelegate(  facebook:Facebook, actor:FacebookUser, 
															title_template:String="", title_data:String="", 
															body_template:String="", body_data:String="", 
															body_general:String="", targetUsers:Array=null,
															image_1:String="", image_1_link:String="",
															image_2:String="", image_2_link:String="",
															image_3:String="", image_3_link:String="",
															image_4:String="", image_4_link:String="")
		{
			super(facebook);
			fbCall.setRequestArgument("actor_id", actor.uid.toString());
			
			if(title_template != "") fbCall.setRequestArgument("title_template", title_template);
			if(title_data != "") fbCall.setRequestArgument("title_data", title_data);
			if(body_template != "") fbCall.setRequestArgument("body_template", body_template);
			if(body_data != "") fbCall.setRequestArgument("body_data", body_data);
			if(body_general != "") fbCall.setRequestArgument("body_general", body_general);
			
			if(targetUsers)
			{
				var target_ids:Array = [];
				for each(var u:FacebookUser in targetUsers)
					target_ids.push(u.uid);
					
				if(target_ids.length > 0)
					fbCall.setRequestArgument("target_ids", target_ids.join(","));
			}
			
			if(image_1 != "") fbCall.setRequestArgument("image_1", image_1);
			if(image_1_link != "") fbCall.setRequestArgument("image_1_link", image_1_link);
			
			if(image_2 != "") fbCall.setRequestArgument("image_2", image_2);
			if(image_2_link != "") fbCall.setRequestArgument("image_2_link", image_2_link);
			
			if(image_3 != "") fbCall.setRequestArgument("image_3", image_3);
			if(image_3_link != "") fbCall.setRequestArgument("image_3_link", image_3_link);
			
			if(image_4 != "") fbCall.setRequestArgument("image_3", image_3);
			if(image_4_link != "") fbCall.setRequestArgument("image_3_link", image_3_link);
			
			fbCall.post("facebook.feed.publishTemplatizedAction");
		}
		
		override protected function handleResult(result:Object):void
		{
			success = result.toString() == "1";
		}
		
	}
}