package com.facebook.graph.data.api.core
{
	/**
	 * Interface for all graph objects.
	 */
	public interface IFacebookGraphObject
	{
		/**
		 * Populates the graph object from a decoded JSON object.
		 * 
		 * @param result A decoded JSON object.
		 */
		function fromJSON( result:Object ):void;
		
		/**
		 * Provides the string value of the graph object.
		 * 
		 * @return The string value of the graph object.
		 */
		function toString():String;
		
	}
}