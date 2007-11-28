package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.groups.FacebookGroup;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.delegates.groups.GetGroupMembers_delegate;
	import com.pbking.facebook.delegates.groups.GetGroups_delegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Groups_test extends TestCase
	{
		private static var facebook:Facebook;
		private var testGroup:FacebookGroup;
		
		// CONSTRUCTION //////////
		
		public function Groups_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Groups_test("testGetGroups"));
			
			//this test needs a group to test with so we will piggyback
			//ts.addTest( new Groups_test("testGetGroupMembers"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test get groups
		 */
		public function testGetGroups():void
		{
			facebook.groups.getGroups(null, null, addAsync(testGetGroupsReply, Facebook_test.timeoutTime));
		}
		private function testGetGroupsReply(e:Event):void
		{
			var d:GetGroups_delegate = e.target as GetGroups_delegate;
			assertTrue(d.errorMessage, d.success);
			
			if(d.groups.length > 0)
			{
				testGroup = d.groups[0];
				testGetGroupMembers();
			}
		}

		/**
		 * Test get group members
		 */
		public function testGetGroupMembers():void
		{
			facebook.groups.getMembers(testGroup, addAsync(testGetGroupMembersReply, Facebook_test.timeoutTime));
		}
		private function testGetGroupMembersReply(e:Event):void
		{
			var d:GetGroupMembers_delegate = e.target as GetGroupMembers_delegate;
			assertTrue(d.errorMessage, d.success);
		}
		
	}
}