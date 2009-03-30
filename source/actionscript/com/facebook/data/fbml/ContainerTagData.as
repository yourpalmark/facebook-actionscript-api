package com.facebook.data.fbml {
	
	import com.facebook.data.fbml.AttributeCollection;
	
	[Bindable]
	public class ContainerTagData extends AbstractTagData {
		
		public var open_tag_fbml:String;
		public var close_tag_fbml:String;
		
		public function ContainerTagData(name:String, header_fbml:String, footer_fbml:String, type:String, 
										open_tag_fbml:String, close_tag_fbml:String,
										description:String = '', is_public:String = '', 
										attributes:AttributeCollection = null) {
			
			this.open_tag_fbml = open_tag_fbml;
			this.close_tag_fbml = close_tag_fbml;
			super(name, header_fbml, footer_fbml, type, description, is_public, attributes);
		}
		
	}
}