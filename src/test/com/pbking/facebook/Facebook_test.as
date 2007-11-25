package com.pbking.facebook
{
	import com.pbking.facebook.delegates.Users_test;
	import com.pbking.facebook.delegates.auth.CreateToken_delegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class Facebook_test extends TestCase
	{
		// VARIABLES //////////
		
		private static var testFacebook:Facebook;
		private static var testApi_key:String;
		private static var testSecret:String;
		
		private const timeoutTime:int = 10000;
		
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
			
			testSuite.addTestSuite(Users_test.suite(testFacebook));
			
			return testSuite;
		}
		
		// TESTS //////////
		
		/**
		 * Test Create Token
		 */
		public function testCreateToken():void
		{
			testFacebook.startNoSession(testApi_key, testSecret);
			var d:CreateToken_delegate = new CreateToken_delegate(testFacebook);
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
			testFacebook.addEventListener("ready", addAsync(onFacebookReady, 10000000, null));
			testFacebook.startDesktopSession(testApi_key, testSecret);
		}
		private function onFacebookReady(e:Event):void
		{
			assertTrue(testFacebook.session_key != "");
			assertTrue(!isNaN(testFacebook.user.uid));
		}
				
	}
}