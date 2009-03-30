package com.facebook.utils {
	
	public class ValidationUtils {
		
		public static function isDataObjectTypeValid(name:String):Boolean {
			if (name == null || name.length > 32) { return false; }
			
			var regExp:RegExp = new RegExp('[^a-z_0-9]', 'ig');
			return !regExp.exec(name);
		}
		
		public static function validateLength(name:String):Boolean {
			var isValid:Boolean = (name == null || name.length >= 255) ? false : true;
			return isValid;
		}

	}
}