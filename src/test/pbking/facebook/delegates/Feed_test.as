package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.feed.PublishActionOfUserDelegate;
	import com.pbking.facebook.delegates.feed.PublishStoryToUserDelegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Feed_test extends TestCase
	{
		private static var facebook:Facebook;
		private var feedTestTitle:String = "has passed a UnitTest for the <a href='http://code.google.com/p/facebook-actionscript-api/'>Facebook AS3 API!</a>";
		private var feedTestBody:String = "If you're reading this then one of the many unit tests was sucessful.  Please check out the API and build something cool!";

		// CONSTRUCTION //////////
		
		public function Feed_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Feed_test("testPublishStoryToUser"));
			
			//the following test is disabled since it could be considered "spam"
			//uncomment it to run it RARELY else your app may be flagged as a spammer
			//ts.addTest( new Feed_test("testPublishActionOfUser"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test Publish to User
		 */
		public function testPublishStoryToUser():void
		{
			facebook.feed.publishStoryToUser(feedTestTitle, feedTestBody, "", "", "", "", "", "", "", "", "", addAsync(testPublishStoryToUserReply, Facebook_test.timeoutTime));
		}
		private function testPublishStoryToUserReply(e:Event):void
		{
			var d:PublishStoryToUserDelegate = e.target as PublishStoryToUserDelegate;
			assertTrue(d.errorMessage, d.success);
		}

		/**
		 * Test Action of User
		 */
		public function testPublishActionOfUser():void
		{
			facebook.feed.publishActionOfUser(feedTestTitle, feedTestBody, "", "", "", "", "", "", "", "", addAsync(testPublishActionOfUserReply, Facebook_test.timeoutTime));
		}
		private function testPublishActionOfUserReply(e:Event):void
		{
			var d:PublishActionOfUserDelegate = e.target as PublishActionOfUserDelegate;
			assertTrue(d.errorMessage, d.success);
		}
	}
}