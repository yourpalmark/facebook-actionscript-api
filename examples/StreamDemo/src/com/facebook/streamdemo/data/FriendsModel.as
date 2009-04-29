package com.facebook.streamdemo.data {
	
	import com.facebook.Facebook;
	import com.facebook.commands.friends.GetFriends;
	import com.facebook.commands.users.GetInfo;
	import com.facebook.data.friends.GetFriendsData;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.FacebookUserCollection;
	import com.facebook.data.users.GetInfoData;
	import com.facebook.data.users.GetInfoFieldValues;
	import com.facebook.events.FacebookEvent;
	import com.facebook.streamdemo.dialogs.MessageWindow;
	import com.facebook.streamdemo.events.StreamEvent;
	import com.gskinner.filesystem.Preferences;
	import com.gskinner.utils.CallLater;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class FriendsModel extends EventDispatcher {
		
		protected static var _instance:FriendsModel;
		protected static var _canInit:Boolean = false;
		
		protected var pendingGetInfoIds:Array;
		protected var getInfoFields:Array;
		protected var getFriendsCall:GetFriends;
		protected var _loggedInUserID:String;
		protected var facebook:Facebook;
		
		/**
		 * All our frineds IDs, used to load there info / Stream and is saved for fast access later. 
		 */
		protected var friendsIDArray:Array;
		protected var friendsHash:Object;
		
		public function FriendsModel() {
			friendsIDArray = Preferences.getPref('friendsIDArray');
			friendsHash = {};
			pendingGetInfoIds = [];
			getInfoFields = [GetInfoFieldValues.NAME, GetInfoFieldValues.PIC_SQUARE, GetInfoFieldValues.PROFILE_URL];
		}
		
		public static function set facebook(value:Facebook):void {
			getInstance().facebook = value;
		}
		
		public static function get friendsIDArray():Array { return getInstance().friendsIDArray; }
		
		public static function loadFriends():void { getInstance().loadFriends(); }
		protected function loadFriends():void {
			if (getFriendsCall) { getFriendsCall.delegate.close(); }
			getFriendsCall = new GetFriends();
			getFriendsCall.addEventListener(FacebookEvent.COMPLETE, onGetFriends, false, 0, true);
			facebook.post(getFriendsCall);
		}
		
		public static function getFriend(uid:String):FacebookUser { return getInstance().getFriend(uid); }
		protected function getFriend(uid:String):FacebookUser {
			if (friendsHash[uid]) {
				return friendsHash[uid];
			} else {
				//Add any new Friend id's to a que, and load them all in half a second or so.
				CallLater.call(requestFriendsList, 15);
				var fbUser:FacebookUser = new FacebookUser();
				fbUser.uid = uid;
				friendsHash[uid] = fbUser;
				
				pendingGetInfoIds.push(uid);
				
				return fbUser;
			}
		}
		
		protected function requestFriendsList():void {
			var getInfoCall:GetInfo = new GetInfo(pendingGetInfoIds.slice(), getInfoFields);
			getInfoCall.addEventListener(FacebookEvent.COMPLETE, onGetUserInfo, false, 0, false);
			facebook.post(getInfoCall);
			
			pendingGetInfoIds = [];
		}
		
		protected function onGetUserInfo(event:FacebookEvent):void {
			event.target.removeEventListener(FacebookEvent.COMPLETE, onGetUserInfo);
			if (event.success) {
				onGetInfo(event.data as GetInfoData);
			} else {
				//trace(event.error.rawResult);
			}
		}
		
		protected function onGetInfo(data:GetInfoData):void {
			var newUsers:FacebookUserCollection = data.userCollection;
			var l:uint = newUsers.length;
			var user:FacebookUser;
			var localUser:FacebookUser
			var fieldsLength:uint;
			
			for (var i:uint=0;i<l;i++) {
				user = newUsers.getItemAt(i) as FacebookUser;
				localUser = friendsHash[user.uid];
				
				fieldsLength = getInfoFields.length;
				while (fieldsLength--) {
					var fld:String = getInfoFields[fieldsLength];
					//Update our local user with new info, bindings will notify all of changes.
					localUser[fld] = user[fld];
				}
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onGetFriends(event:FacebookEvent):void {
			if (event.success == false) {
				MessageWindow.show('Error loading your friends.', 'Error');
			} else {
				var fbUsers:FacebookUserCollection = (event.data as GetFriendsData).friends;
				var l:uint = fbUsers.length;
				friendsIDArray = [];
				var fbUser:FacebookUser;
				
				for (var i:uint=0;i<l;i++) {
					fbUser = (fbUsers.getItemAt(i) as FacebookUser);
					friendsIDArray.push(fbUser.uid);
					friendsHash[fbUser.uid] = fbUser;
				}
				
				//Add in our logged in user
				fbUser = new FacebookUser();
				fbUser.uid = _loggedInUserID;
				friendsIDArray.push(_loggedInUserID);
				friendsHash[_loggedInUserID] = fbUser;
				
				getFriendsInfo();
			}
		}
		
		protected function getFriendsInfo():void {
			var getInfoCall:GetInfo = new GetInfo(friendsIDArray, getInfoFields);
			getInfoCall.addEventListener(FacebookEvent.COMPLETE, onInitialUserInfoComplete);
			
			facebook.post(getInfoCall);
		}
		
		//The intial load handler
		protected function onInitialUserInfoComplete(event:FacebookEvent):void {
			var result:GetInfoData = (event.data as GetInfoData);
			onGetInfo(result);
			
			dispatchEvent(new StreamEvent(StreamEvent.LOAD_FRIENDS));
		}
		
		public static function getInstance():FriendsModel {
			if (_instance == null) { _canInit = true;  _instance = new FriendsModel(); _canInit = false; }
			return _instance;
		}
		
	}
}