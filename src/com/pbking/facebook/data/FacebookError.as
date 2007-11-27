package com.pbking.facebook.data
{
	import flash.utils.Dictionary;
	
	public class FacebookError
	{
		private static var _errorCodes:Dictionary;
		
		public static function get errorCodes():Dictionary
		{
			if(!_errorCodes)
				initErrorCodes();

			return _errorCodes();
		}
		
		public static function getErrorString(errorNumber:int):String
		{
			var codeString:String = errorCodes[errorNumber];
			
			if(!codeString || codeString == "")
				codeString = "No error string";
				
			return codeString;
		}
		
		private function initErrorCodes():void
		{
			_errorCodes = new Dictionary();
			
			_errorCodes[1] = "An unknown error occurred. Please resubmit the request.";
			_errorCodes[2] = "The service is not available at this time.";
			_errorCodes[4] = "The application has reached the maximum number of requests allowed. More requests are allowed once the time window has completed.";
			_errorCodes[5] = "The request came from a remote address not allowed by this application.";
			_errorCodes[101] = "The api key submitted is not associated with any known application.";
			_errorCodes[102] = "The session key was improperly submitted or has reached its timeout. Direct the user to log in again to obtain another key.";
			_errorCodes[103] = "The submitted call_id was not greater than the previous call_id for this session.";
			_errorCodes[104] = "Incorrect signature.";
			
			_errorCodes[110] = "Invalid user ID.";
			_errorCodes[121] = "Invalid photo ID.";
			_errorCodes[240] = "The uid cannot be specified from a desktop application.";
			_errorCodes[260] = "Modifying existing photos requires the extended permission photo_upload. ";
			_errorCodes[322] = "Invalid photo tag subject.";
			_errorCodes[323] = "Cannot tag photo already visible on Facebook.";
			_errorCodes[326] = "Too many photo tags pending.";
			_errorCodes[330] = "The markup was invalid";
		}
	}
}