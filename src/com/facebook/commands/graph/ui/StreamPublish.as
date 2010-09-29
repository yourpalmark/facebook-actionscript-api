package com.facebook.commands.graph.ui
{
	import com.adobe.serialization.json.JSON;
	import com.facebook.commands.graph.core.UI;
	import com.facebook.facebook_internal;
	
	use namespace facebook_internal;
	
	public class StreamPublish extends UI
	{
		public static const METHOD_NAME:String = 'stream.publish';
		
		public var message:String;
		public var attachment:Object;
		public var action_links:Array;
		public var target_id:String;
		public var uid:String;
		public var privacy:Object;
		
		public function StreamPublish( message:String=null, attachment:Object=null, action_links:Array=null, target_id:String=null, uid:String=null, privacy:Object=null )
		{
			method = METHOD_NAME;
			this.message = message;
			this.attachment = attachment;
			this.action_links = action_links;
			this.target_id = target_id;
			this.uid = uid;
			this.privacy = privacy;
			
			super( params );
		}
		
		override facebook_internal function formatParams():void
		{
			super.formatParams();
			if( message ) params.message = message;
			if( attachment ) params.attachment = JSON.encode( attachment );
			if( action_links ) params.action_links = JSON.encode( action_links );
			if( target_id ) params.target_id = target_id;
			if( uid ) params.uid = uid;
			if( privacy ) params.privacy = JSON.encode( privacy );
		}
		
	}
}