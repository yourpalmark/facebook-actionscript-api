package  com.facebook.data.notifications {
	
	import com.facebook.data.FacebookData;

	[Bindable]
	public class GetNotificationData extends FacebookData {
		
		public var friendsRequests:Array;
		public var group_invites:Array;
		public var event_invites:Array;
		
		public var notificationCollection:NotificationCollection;

		
		public function GetNotificationData() {
			super();

		}

	}

}