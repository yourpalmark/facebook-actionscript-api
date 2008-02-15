package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.users.UserFields;
	import com.pbking.facebook.delegates.users.GetLoggedInUserDelegate;
	import com.pbking.facebook.delegates.users.GetUserInfoDelegate;
	import com.pbking.facebook.delegates.users.HasAppPermissionDelegate;
	import com.pbking.facebook.delegates.users.IsAppAddedDelegate;
	import com.pbking.facebook.delegates.users.SetStatusDelegate;
	
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
			ts.addTest( new Users_test("testGetUserInfo"));
			ts.addTest( new Users_test("testHasAppPermission"));
			ts.addTest( new Users_test("testIsAppAdded"));
			ts.addTest( new Users_test("testSetStatus"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test GetLoggedInUser
		 */
		public function testGetLoggedInUser():void
		{
			facebook.users.getLoggedInUser(addAsync(testGetLoggedInUserReply, Facebook_test.timeoutTime));
		}
		private function testGetLoggedInUserReply(e:Event):void
		{
			var d:GetLoggedInUserDelegate = e.target as GetLoggedInUserDelegate;
			assertTrue(d.errorMessage, d.success);
			assertTrue("matches session defined user", d.user.uid == facebook.user.uid);
		}

		/**
		 * Test GetUserInfo
		 */
		public function testGetUserInfo():void
		{
			facebook.users.getInfo([facebook.user], UserFields.entire_collection, addAsync(testGetUserInfoReply, Facebook_test.timeoutTime));
		}
		private function testGetUserInfoReply(e:Event):void
		{
			var d:GetUserInfoDelegate = e.target as GetUserInfoDelegate;
			//because the info saved for each person differs, we can only really test to make sure the call was sucessful
			assertTrue(d.errorMessage, d.success);
		}
		
		/**
		 * Test SetStatus
		 */
		public function testSetStatus():void
		{
			facebook.users.setStatus("setting status", false, addAsync(testSetStatusReply, Facebook_test.timeoutTime));
		}
		private function testSetStatusReply(e:Event):void
		{
			var d:SetStatusDelegate = e.target as SetStatusDelegate;
			if(d.errorCode == 250) //Updating status requires the extended permission status_update
				assertFalse(d.success);
			else
				assertTrue(d.errorMessage, d.success);
		}
		
		/**
		 * Test HasAppPermission
		 */
		public function testHasAppPermission():void
		{
			facebook.users.hasAppPermission("status_update", addAsync(testHasAppPermissionReply, Facebook_test.timeoutTime));
			facebook.users.hasAppPermission("create_listing", addAsync(testHasAppPermissionReply, Facebook_test.timeoutTime));
			facebook.users.hasAppPermission("photo_upload", addAsync(testHasAppPermissionReply, Facebook_test.timeoutTime));
		}
		private function testHasAppPermissionReply(e:Event):void
		{
			var d:HasAppPermissionDelegate = e.target as HasAppPermissionDelegate;
			assertTrue(d.errorMessage, d.success);
		}
		
		/**
		 * Test IsAppAdded
		 */
		public function testIsAppAdded():void
		{
			facebook.users.isAppAdded(addAsync(testIsAppAddedReply, Facebook_test.timeoutTime));
		}
		private function testIsAppAddedReply(e:Event):void
		{
			var d:IsAppAddedDelegate = e.target as IsAppAddedDelegate;
			assertTrue(d.errorMessage, d.success);
			assertTrue(d.isAdded);
		}
	}
}