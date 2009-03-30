package com.facebook.data.feed {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetRegisteredTemplateBundleByIDData extends FacebookData {
		
		public var templateCollection:TemplateCollection;
		
		public function GetRegisteredTemplateBundleByIDData() {
			super();
		}
	}
}