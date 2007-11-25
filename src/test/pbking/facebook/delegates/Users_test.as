package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.users.GetLoggedInUser_delegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Users_test extends TestCase
	{
		private static var facebook:Facebook;
		
		// CONSTRUCTION //////////
		
		public function Users_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Users_test("testGetLoggedInUser"));
			
			return ts;
		}
		
		// TESTS //////////
		
		public function testGetLoggedInUser():void
		{
			facebook.users.getLoggedInUser(addAsync(testGetLoggedInUserReply, Facebook_test.timeoutTime));
		}
		private function testGetLoggedInUserReply(e:Event):void
		{
			var d:GetLoggedInUser_delegate = e.target as GetLoggedInUser_delegate;
			assertTrue("call sucessful: ", d.success);
			assertTrue("matches session defined user: ", d.user.uid == facebook.user.uid);
		}
	}
}