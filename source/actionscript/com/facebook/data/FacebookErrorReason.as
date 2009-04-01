package com.facebook.data {
	/**
	 * An enumeration class that defines constants to represent the
	 * reasons for an error. Used internally by the WebDelegate class.
	 * @see com.facebook.delegates.WebDelegate
	 */
	[Bindable]
	public class FacebookErrorReason {
		
		public static const CONNECT_TIMEOUT:String = 'connectTimeout';
		public static const LOAD_TIMEOUT:String = 'loadTimeout';

	}
}