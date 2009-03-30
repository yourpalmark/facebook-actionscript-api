package com.facebook.data.feed {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class TemplateCollection extends FacebookArrayCollection {
		
		public var time_created:Date;
		public var template_bundle_id:Number
		
		public function TemplateCollection() {
			super(null, TemplateData);
		}
		
		public function addTemplateData(templateData:TemplateData):void {
			this.addItem(templateData);
		}
		
	}
}