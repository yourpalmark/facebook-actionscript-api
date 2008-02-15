package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.friends.AreFriendsDelegate;
	import com.pbking.facebook.delegates.friends.GetAppUsersDelegate;
	import com.pbking.facebook.delegates.friends.GetFriendsDelegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Friends_test extends TestCase
	{
		private static var facebook:Facebook;
		private var myFriends:Array;
		
		// CONSTRUCTION //////////
		
		public function Friends_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Friends_test("testGetFriends"));
			ts.addTest( new Friends_test("testGetAppUsers"));
			
			//these tests require a list of friends (conveniently returned
			//in the get friends test).  These test are just piggybacked
			//on the backend of that one.
			//ts.addTest( new Friends_test("testAreFriends"));
			//ts.addTest( new Friends_test("testAreFriends2"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test get friends
		 */
		public function testGetFriends():void
		{
			facebook.friends.getFriends(addAsync(getFriendsReply, Facebook_test.timeoutTime));
		}
		private function getFriendsReply(e:Event):void
		{
			var d:GetFriendsDelegate = e.target as GetFriendsDelegate;
			assertTrue(d.errorMessage, d.success);
			myFriends = d.friends
			
			testAreFriends();
			testAreFriends2();
		}
		
		/**
		 * Test are friends
		 */
		public function testAreFriends():void
		{
			facebook.friends.areFriends([facebook.user], [myFriends[0]], addAsync(testAreFriendsReply, Facebook_test.timeoutTime));
		}
		private function testAreFriendsReply(e:Event):void
		{
			var d:AreFriendsDelegate = e.target as AreFriendsDelegate;
			assertTrue(d.errorMessage, d.success);
			assertTrue("list1 has user", d.list1[0] == facebook.user);
			assertTrue("list2 has friend 0", d.list2[0] == myFriends[0]);
			assertTrue("are friends", d.resultList[0]);
		}
		
		/**
		 * Test are friends2
		 */
		public function testAreFriends2():void
		{
			facebook.friends.areFriends2(facebook.user, myFriends, addAsync(testAreFriendsReply, Facebook_test.timeoutTime));
		}
		private function testAreFriends2Reply(e:Event):void
		{
			var d:AreFriendsDelegate = e.target as AreFriendsDelegate;
			assertTrue(d.errorMessage, d.success);
			assertTrue("list1 has user", d.list1[0] == facebook.user);
			assertTrue("list2 has friend 0", d.list2[0] == myFriends[0]);
			assertTrue("are friends", d.resultList[0]);
		}
		
		/**
		 * Test get app users
		 */
		public function testGetAppUsers():void
		{
			facebook.friends.getAppUsers(addAsync(testGetAppUsersReply, Facebook_test.timeoutTime));
		}
		private function testGetAppUsersReply(e:Event):void
		{
			var d:GetAppUsersDelegate = e.target as GetAppUsersDelegate;
			assertTrue(d.errorMessage, d.success);
		}
		
	}
}