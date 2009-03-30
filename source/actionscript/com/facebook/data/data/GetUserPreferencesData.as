package com.facebook.data.data {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetUserPreferencesData extends FacebookData {
		
		public var perferenceCollection:PreferenceCollection;
		
		public function GetUserPreferencesData() {
			super();
		}
		
	}
}