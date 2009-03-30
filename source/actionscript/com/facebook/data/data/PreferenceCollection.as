package com.facebook.data.data {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class PreferenceCollection extends FacebookArrayCollection {
		
		public function PreferenceCollection() {
			super(null, PreferenceData);
		}
		
	}
}