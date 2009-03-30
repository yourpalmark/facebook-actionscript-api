package com.facebook.data.feed {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetRegisteredTemplateBundleData extends FacebookData {
		
		public var bundleCollection:TemplateCollection;
		
		public function GetRegisteredTemplateBundleData() {
			super();
		}
		
	}
}