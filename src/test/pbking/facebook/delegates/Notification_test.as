package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.notifications.GetNotifications_delegate;
	import com.pbking.facebook.delegates.notifications.SendNotification_delegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Notification_test extends TestCase
	{
		private static var facebook:Facebook;
		
		private var fbmlTestContent:String = "<a href='http://code.google.com/p/facebook-actionscript-api/'>Facebook AS3 API Rawks!</a>";

		// CONSTRUCTION //////////
		
		public function Notification_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Notification_test("testSend"));
			ts.addTest( new Notification_test("testGetNotifications"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test Set Notifications
		 */
		public function testSend():void
		{
			facebook.notifications.send(fbmlTestContent, null, addAsync(testSendReply, Facebook_test.timeoutTime));
		}
		private function testSendReply(e:Event):void
		{
			var d:SendNotification_delegate = e.target as SendNotification_delegate;
			assertTrue(d.errorMessage, d.success);
			
		}
		
		/**
		 * Test Get Notifications
		 */
		public function testGetNotifications():void
		{
			facebook.notifications.getNotifications(addAsync(testGetNotificationsReply, Facebook_test.timeoutTime));
		}
		private function testGetNotificationsReply(e:Event):void
		{
			var d:GetNotifications_delegate = e.target as GetNotifications_delegate;
			assertTrue(d.errorMessage, d.success);
			
		}
		
	}
}