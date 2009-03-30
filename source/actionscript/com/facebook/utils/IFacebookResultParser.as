package com.facebook.utils {
	
	import com.facebook.data.FacebookData;
	import com.facebook.errors.FacebookError;

	public interface IFacebookResultParser {
		
		function parse(result:String, methodName:String):FacebookData;
		function validateFacebookResponce(result:String):FacebookError;
		
	}
}