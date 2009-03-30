package com.facebook.data.application {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetPublicInfoData extends FacebookData {
		
		public var app_id:String;
		public var api_key:String;
	    public var canvas_name:String;
	    public var display_name:String;
	    public var icon_url:String;
	    public var logo_url:String;
	    public var developers:String; //SD might have to change dataType
	    public var company_name:String;
	    public var description:String;
	    public var daily_active_users:Number;
	    public var weekly_active_users:Number;
	    public var monthly_active_users:Number;
		
		public function GetPublicInfoData() {
			super();
		}
		
	}
}