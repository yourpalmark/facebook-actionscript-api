package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.events.FacebookEvent;
	import com.pbking.facebook.delegates.events.GetEventMembersDelegate;
	import com.pbking.facebook.delegates.events.GetEventsDelegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Events_test extends TestCase
	{
		private static var facebook:Facebook;
		private var testEvent:FacebookEvent;

		// CONSTRUCTION //////////
		
		public function Events_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Events_test("testGetEvents"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test get events
		 */
		public function testGetEvents():void
		{
			facebook.events.getEvents(null, null, null, null, "", addAsync(testGetEventsReply, Facebook_test.timeoutTime));
		}
		private function testGetEventsReply(e:Event):void
		{
			var d:GetEventsDelegate = e.target as GetEventsDelegate;
			assertTrue(d.errorMessage, d.success);
			
			if(d.events.length > 0)
			{
				testEvent = d.events[0];
				testGetEventMembers();
			}
		}

		/**
		 * Test get event members
		 */
		public function testGetEventMembers():void
		{
			facebook.events.getEventMembers(testEvent, addAsync(testGetEventMembersReply, Facebook_test.timeoutTime));
		}
		private function testGetEventMembersReply(e:Event):void
		{
			var d:GetEventMembersDelegate = e.target as GetEventMembersDelegate;
			assertTrue(d.errorMessage, d.success);
		}
	}
}