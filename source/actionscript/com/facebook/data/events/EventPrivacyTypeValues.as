package com.facebook.data.events {
	
	[Bindable]
	public class EventPrivacyTypeValues {
		
		public static const OPEN:String = 'OPEN'; // for an event open and visible to everyone.
		public static const CLOSED:String = 'CLOSED'; //, for an event that is visible to everyone but requires an invitation.
		public static const SECRET:String = 'SECRET'; //, for an event that is invisible to those who have not been invited. 

	}
}