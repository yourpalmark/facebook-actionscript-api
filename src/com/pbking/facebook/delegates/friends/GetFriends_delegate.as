package com.pbking.facebook.delegates.friends
{
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class GetFriends_delegate extends FacebookDelegate
	{
		public var friends:Array;
		
		public function GetFriends_delegate()
		{
			PBLogger.getLogger("pbking.facebook").debug("getting friends");
			
			fbCall.post("facebook.friends.get");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			friends = [];
			
			var xFriendsList:XMLList = resultXML..uid;
			for each(var xUID:XML in xFriendsList)
			{
				friends.push(fBook.getUser(parseInt(xUID)));
			} 
		}
		
	}
}