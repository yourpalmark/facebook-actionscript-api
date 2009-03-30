package com.facebook.data.users {
	
	import com.facebook.utils.FacebookArrayCollection;

	[Bindable]
	public class AffiliationCollection extends FacebookArrayCollection {
		
		public function AffiliationCollection() {
			super(null, AffiliationData);
		}
		
		public function addAffiliation(affiliationData:AffiliationData):void {
			this.addItem(affiliationData);
		}
		
	}
}