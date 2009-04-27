package com.facebook.commands.application {
	
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;
	
	use namespace facebook_internal;

	/**
	 * The GetPublicInfo class represents the public  
      Facebook API known as Application.getPublicInfo.
	 * @see http://wiki.developers.facebook.com/index.php/Application.getPublicInfo
	 */
	public class GetPublicInfo extends FacebookCall {

		
		public static const METHOD_NAME:String = 'application.getPublicInfo';
		public static const SCHEMA:Array = ['application_id','application_api_key','application_canvas_name'];
		
		public var application_id:String;
		public var application_api_key:String;
		public var application_canvas_name:String;
		
		
		public function GetPublicInfo(application_id:String=null, application_api_key:String=null, application_canvas_name:String=null) {
			super(METHOD_NAME);
			
			if (application_id == null && application_api_key==null && application_canvas_name==null) {
				throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
			}
			
			if (application_id == null && (application_api_key==null || application_canvas_name==null)) {
				throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
			}
			
			if (application_api_key == null && (application_id==null || application_canvas_name==null)) {
				throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
			}
			
			if (application_canvas_name == null && (application_id==null || application_api_key==null)) {
				throw new Error("You must specify exactly one of application_id, application_api_key or application_canvas_name.");
			}
			
			this.application_id = application_id;
			this.application_api_key = application_api_key;
			this.application_canvas_name = application_canvas_name;
		}
		
		override facebook_internal function initialize():void {
			this.applySchema(SCHEMA, application_id, application_api_key, application_canvas_name);
			super.facebook_internal::initialize();
		}
	}
}