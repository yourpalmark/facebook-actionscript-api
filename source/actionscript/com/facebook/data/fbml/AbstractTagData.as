/**
 * 
 * Abstract class created due to the fact that when submitting a type leaf/container, was generating a invalid parameter error.
 * Should use one of the more specific TagClasses to register tag data (ex:LeafTagData or ContainerTagData).
 */ 
package com.facebook.data.fbml {
	
	import com.facebook.data.fbml.AttributeCollection;
	
	[Bindable]
	public class AbstractTagData {
		
		public var name:String;
		public var type:String;
		public var description:String;
		public var is_public:String;
		public var attributes:AttributeCollection;
		public var header_fbml:String;
		public var footer_fbml:String;
		
		public function AbstractTagData(name:String, header_fbml:String, footer_fbml:String, type:String, 
										description:String = '', is_public:String = '',
										attributes:AttributeCollection = null) {
											
			this.name = name;
			this.type = type;
			this.description = description;
			this.is_public = is_public;
			this.header_fbml = header_fbml;
			this.footer_fbml = footer_fbml;
			this.attributes = attributes;
		}

	}
}