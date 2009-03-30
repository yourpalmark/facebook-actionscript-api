package com.facebook.data.fbml {
	
	import com.facebook.data.fbml.AttributeCollection;
	
	[Bindable]
	public class LeafTagData extends AbstractTagData {
		
		public var fbml:String;		
		
		public function LeafTagData(name:String, fbml:String, header_fbml:String, footer_fbml:String, type:String, 
									description:String = '', is_public:String = '', 
									attributes:AttributeCollection = null) {
			this.fbml = fbml;
			
			super(name, header_fbml, footer_fbml, type, description, is_public, attributes);
		}

	}
}