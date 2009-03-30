package com.facebook.data.connect {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class ConnectAccountMapCollection extends FacebookArrayCollection {
		
		public function ConnectAccountMapCollection() {
			super(null, ConnectAccountMapData);
		}
	}
}