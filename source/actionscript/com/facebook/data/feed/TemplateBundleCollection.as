package com.facebook.data.feed {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class TemplateBundleCollection extends FacebookArrayCollection {
		
		public function TemplateBundleCollection() {
			super(null, TemplateData);
		}
		
	}
}