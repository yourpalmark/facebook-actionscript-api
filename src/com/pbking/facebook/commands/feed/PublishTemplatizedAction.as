package com.pbking.facebook.delegates.feed
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.users.FacebookUser;

	public class PublishTemplatizedAction extends FacebookCall
	{
		
		public var title_template:String;
		public var title_data:String;
		public var body_template:String;
		public var body_data:String;
		public var body_general:String;
		public var targetUsers:Array;
		public var image_1:String;
		public var image_1_link:String;
		public var image_2:String;
		public var image_2_link:String;
		public var image_3:String;
		public var image_3_link:String;
		public var image_4:String;
		public var image_4_link:String;
		
		public function PublishTemplatizedAction(  actor:FacebookUser, 
															title_template:String="", title_data:String="", 
															body_template:String="", body_data:String="", 
															body_general:String="", targetUsers:Array=null,
															image_1:String="", image_1_link:String="",
															image_2:String="", image_2_link:String="",
															image_3:String="", image_3_link:String="",
															image_4:String="", image_4_link:String="")
		{
			super("facebook.feed.publishTemplatizedAction");
			
			this.title_template = title_template;
			this.title_data = title_data;
			this.body_template = body_template;
			this.body_data = body_data;
			this.body_general = body_general;
			this.targetUsers = targetUsers;
			this.image_1 = image_1;
			this.image_1_link = image_1_link;
			this.image_2 = image_2;
			this.image_2_link = image_2_link;
			this.image_3 = image_3;
			this.image_3_link = image_3_link;
			this.image_4 = image_4;
			this.image_4_link = image_4_link;
		}
		
		override public function initialize():void
		{
			clearRequestArguments();
			
			setRequestArgument("actor_id", actor.uid.toString());
			
			if(title_template != "") 
				setRequestArgument("title_template", title_template);
				
			if(title_data != "") 
				setRequestArgument("title_data", title_data);
				
			if(body_template != "") 
				setRequestArgument("body_template", body_template);
				
			if(body_data != "") 
				setRequestArgument("body_data", body_data);
				
			if(body_general != "") 
				setRequestArgument("body_general", body_general);
			
			if(targetUsers)
			{
				var target_ids:Array = [];
				
				for (var i:int=0; i<targetUsers.length; i++)
				{
					target_ids.push(targetUsers[i] is FacebookUser ? targetUsers[i].uid : targetUsers[i]);
				}
					
				if(target_ids.length > 0)
					setRequestArgument("target_ids", target_ids.join(","));
			}
			
			if(image_1 != "") 
				setRequestArgument("image_1", image_1);
			if(image_1_link != "") 
				setRequestArgument("image_1_link", image_1_link);
			
			if(image_2 != "") 
				setRequestArgument("image_2", image_2);
			if(image_2_link != "") 
				setRequestArgument("image_2_link", image_2_link);
			
			if(image_3 != "") 
				setRequestArgument("image_3", image_3);
			if(image_3_link != "") 
				setRequestArgument("image_3_link", image_3_link);
			
			if(image_4 != "") 
				setRequestArgument("image_4", image_4);
			if(image_4_link != "") 
				setRequestArgument("image_4_link", image_4_link);
			
		}
		
	}
}