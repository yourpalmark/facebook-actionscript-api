/*
  Copyright (c) 2009, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
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