/**
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
* Copyright (c) 2009 Grant Skinner
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
**/
package com.gskinner.controls {
	
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	
	import mx.controls.Text;
	import mx.core.mx_internal;
	import mx.core.IUITextField;

	use namespace mx_internal;
	
	public class HTMLText extends Text {
		
		protected var _embedFonts:Boolean;
		
		public function setStyleSheet(p_styleSheet:StyleSheet, p_embedFonts:Boolean = true):void {
			styleSheet = p_styleSheet;
			
			_embedFonts = p_embedFonts;
			textField.embedFonts = p_embedFonts;
		}
		
		public function get field():IUITextField {
			return textField;
		}
		
		override  mx_internal function createTextField(childIndex:int):void {
			super.mx_internal::createTextField(childIndex);
			
			textField.embedFonts = _embedFonts;
			textField.multiline = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
		}
	}
}