package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.fql.FqlQueryDelegate;
	
	import flash.events.Event;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Fql_test extends TestCase
	{
		private static var facebook:Facebook;

		// CONSTRUCTION //////////
		
		public function Fql_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Fql_test("testQuery"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test FQL Query
		 */
		public function testQuery():void
		{
			//test query pulled from facebook wiki
			var testQuery:String = 'SELECT name, affiliations FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1='+facebook.user.uid+') AND "Facebook" IN affiliations.name AND uid < 10';
			facebook.fql.query(testQuery, addAsync(testQueryReply, Facebook_test.timeoutTime));
		}
		private function testQueryReply(e:Event):void
		{
			var d:FqlQueryDelegate = e.target as FqlQueryDelegate;
			assertTrue(d.errorMessage, d.success);
			
		}
	}
}