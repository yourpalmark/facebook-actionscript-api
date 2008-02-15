package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.profile.GetFBMLDelegate;
	import com.pbking.facebook.delegates.profile.SetFBMLDelegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Profile_test extends TestCase
	{
		private static var facebook:Facebook;
		private var fbmlTestContent:String = "<a href='http://code.google.com/p/facebook-actionscript-api/'>Facebook AS3 API Rawks!</a>";
		
		// CONSTRUCTION //////////
		
		public function Profile_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Profile_test("testSetFBML"));
			ts.addTest( new Profile_test("testGetFBML"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test Set FBML
		 */
		public function testSetFBML():void
		{
			facebook.profile.setFBML(fbmlTestContent, null, addAsync(testSetFBMLReply, Facebook_test.timeoutTime));
		}
		private function testSetFBMLReply(e:Event):void
		{
			var d:SetFBMLDelegate = e.target as SetFBMLDelegate;
			assertTrue(d.errorMessage, d.success);
			
		}
		
		/**
		 * Test Get FBML
		 */
		public function testGetFBML():void
		{
			facebook.profile.getFBML(null, addAsync(testGetFBMLReply, Facebook_test.timeoutTime));
		}
		private function testGetFBMLReply(e:Event):void
		{
			var d:GetFBMLDelegate = e.target as GetFBMLDelegate;
			assertTrue(d.errorMessage, d.success);
		}

	}
}