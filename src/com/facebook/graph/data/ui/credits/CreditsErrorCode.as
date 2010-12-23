package com.facebook.graph.data.ui.credits
{
	public class CreditsErrorCode
	{
		/**
		 * Facebook system issue.
		 */
		public static const UNKNOWN:int = 1383001;
		
		/**
		 * Developer called with the incorrect parameters.
		 */
		public static const INVALID_PARAMETERS:int = 1383002;
		
		/**
		 * Processor decline.
		 */
		public static const PAYMENT_FAILURE:int = 1383003;
		
		/**
		 * Developer attempted an operation Facebook does not allow.
		 */
		public static const INVALID_OPERATION:int = 1383004;
		
		/**
		 * Facebook system issue.
		 */
		public static const PERMISSION_DENIED:int = 1383005;
		
		/**
		 * Facebook system issue.
		 */
		public static const DATABASE_ERROR:int = 1383006;
		
		/**
		 * App is not whitelisted.
		 * Or while in test mode, developer attempted to debit a user that was not whitelisted.
		 */
		public static const INVALID_APP:int = 1383007;
		
		/**
		 * App is not responding to us at all.
		 * Developer has an issue.
		 */
		public static const APP_NO_RESPONSE:int = 1383008;
		
		/**
		 * App is not responding to us correctly.
		 * Developer has an issue.
		 */
		public static const APP_ERROR_RESPONSE:int = 1383009;
		
		/**
		 * User explicitly cancelled out of flow.
		 */
		public static const USER_CANCELED:int = 1383010;
		
		/**
		 * Facebook system issue.
		 */
		public static const DISABLED:int = 1383011;
		
		/**
		 * Facebook decline.
		 */
		public static const CAPTCHA_FAILED:int = 1353010;
		
		/**
		 * Facebook decline.
		 */
		public static const SECURITY_BLOCKED:int = 1353011;
		
	}
}