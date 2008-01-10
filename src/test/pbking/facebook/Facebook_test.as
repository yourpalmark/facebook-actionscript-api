package test.pbking.facebook
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.auth.CreateToken_delegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.delegates.Events_test;
	import test.pbking.facebook.delegates.Feed_test;
	import test.pbking.facebook.delegates.Fql_test;
	import test.pbking.facebook.delegates.Friends_test;
	import test.pbking.facebook.delegates.Groups_test;
	import test.pbking.facebook.delegates.Notification_test;
	import test.pbking.facebook.delegates.Photos_test;
	import test.pbking.facebook.delegates.Profile_test;
	import test.pbking.facebook.delegates.Users_test;

	public class Facebook_test extends TestCase
	{
		// VARIABLES //////////
		
		private static var testFacebook:Facebook;
		private static var testApi_key:String;
		private static var testSecret:String;
		
		public static const timeoutTime:int = 20000;
		
		// CONSTRUCTION //////////
		
		public function Facebook_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(facebook:Facebook, api_key:String, secret:String):TestSuite
		{
			testApi_key = api_key;
			testSecret = secret;
			testFacebook = facebook;
			
			var testSuite:TestSuite = new TestSuite();	
					
			testSuite.addTest(new Facebook_test("testCreateToken"));
			testSuite.addTest(new Facebook_test("testStartDesktopSession"));
			
			testSuite.addTest(Users_test.suite(testFacebook));
			testSuite.addTest(Profile_test.suite(testFacebook));
			testSuite.addTest(Notification_test.suite(testFacebook));
			testSuite.addTest(Friends_test.suite(testFacebook));
			testSuite.addTest(Groups_test.suite(testFacebook));
			testSuite.addTest(Fql_test.suite(testFacebook));
			testSuite.addTest(Events_test.suite(testFacebook));
			testSuite.addTest(Feed_test.suite(testFacebook));
			testSuite.addTest(Photos_test.suite(testFacebook));
			
			return testSuite;
		}
		
		// TESTS //////////
		
		/**
		 * Test Create Token
		 */
		public function testCreateToken():void
		{
			testFacebook.startNoSession(testApi_key, testSecret);
			var d:CreateToken_delegate = new CreateToken_delegate();
			d.addEventListener(Event.COMPLETE, addAsync(onTestCreateTokenReply, timeoutTime));
		}
		private function onTestCreateTokenReply(e:Event):void
		{
			var d:CreateToken_delegate = e.target as CreateToken_delegate;
			assertTrue("create token call successful: ", d.success);
			assertTrue("token created: ", d.auth_token != ""); 
		}
		
		/**
		 * Test Start Desktop Session
		 */
		public function testStartDesktopSession():void
		{
			testFacebook.addEventListener(Event.COMPLETE, addAsync(testStartDesktopSessionReply, 10000000, null));
			testFacebook.startDesktopSession(testApi_key, testSecret);
		}
		private function testStartDesktopSessionReply(e:Event):void
		{
			assertTrue("facebook connected", testFacebook.isConnected);
		}
				
	}
}