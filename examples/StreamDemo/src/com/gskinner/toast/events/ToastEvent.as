package com.gskinner.toast.events {
	import flash.events.Event;

	public class ToastEvent extends Event {
		
		public static const TICK:String = "tick";
		
		public function ToastEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new ToastEvent(type, bubbles, cancelable);
		}
		
	}
}