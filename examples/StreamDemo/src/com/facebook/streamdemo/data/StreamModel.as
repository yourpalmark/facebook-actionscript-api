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
	
	import com.chewtinfoil.utils.StringUtils;
	import com.facebook.Facebook;
	import com.facebook.commands.stream.AddComment;
	import com.facebook.commands.stream.AddLike;
	import com.facebook.commands.stream.GetStream;
	import com.facebook.commands.stream.RemoveComment;
	import com.facebook.commands.stream.RemoveLike;
	import com.facebook.data.stream.GetStreamData;
	import com.facebook.data.stream.StreamStoryData;
	import com.facebook.events.FacebookEvent;
	import com.facebook.streamdemo.events.StreamEvent;
	import com.facebook.utils.FacebookDataUtils;
	import com.gskinner.toast.data.NotificationData;
	
	import fb.FBConnect;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class StreamModel extends EventDispatcher {
		
		protected static var _instance:StreamModel;
		protected static var _canInit:Boolean = false;
		
		protected var getStreamCall:GetStream;
		protected var lastUpdate:Date;
		
		protected var storyStreamsHash:Object;
		protected var albumsStreamHash:Object;
		protected var facebook:Facebook;
		protected var dataProvider:ArrayCollection;
		
		protected var refreshTimer:Timer;
		
		protected static const STREAM_UPDATE_TEXT:String = "{actor}'s story \"{story}\" has been updated.";
		
		public function StreamModel() {
			super();
			
			storyStreamsHash = {};
			albumsStreamHash = {};
			
			refreshTimer = new Timer(1000*60*2);
			refreshTimer.addEventListener(TimerEvent.TIMER, onRefreshTimer, false, 0, true);
		}
		
		public static function resume():void { getInstance().resume(); }
		protected function resume():void {
			refreshTimer.start();
		}
		
		public static function pause():void { getInstance().pause(); }
		protected function pause():void {
			refreshTimer.stop();
		}
		
		public static function set facebook(value:Facebook):void {
			getInstance().facebook = value;
		}
		
		public static function get dataProvider():ArrayCollection { return getInstance().dataProvider; }
		
		public static function addComment(story_id:String, body:String):void { getInstance().addComment(story_id, body); }
		protected function addComment(story_id:String, body:String):void {
			var call:AddComment = new AddComment(story_id, body);
			call.addEventListener(FacebookEvent.COMPLETE, onAddComment);
			facebook.post(call);
		}
		public static function removeComment(comment_id:String, uid:String):void { getInstance().removeComment(comment_id, uid); }
		protected function removeComment(comment_id:String, uid:String):void {
			var call:RemoveComment = new RemoveComment(comment_id, uid);
			call.addEventListener(FacebookEvent.COMPLETE, onRemoveComment);
			facebook.post(call);
		}
		
		protected function onRefreshTimer(event:TimerEvent):void {
			refresh();
		}
		
		protected function onRemoveComment(event:FacebookEvent):void {
			dispatchEvent(new StreamEvent(StreamEvent.COMMENT_REMOVED, false, false, event.success?event.data:event.error));
		}
		
		protected function onAddComment(event:FacebookEvent):void {
			dispatchEvent(new StreamEvent(StreamEvent.COMMENT_ADDED, false, false, event.success?event.data:event.error));
		}
		
		public static function likeStory(story_id:String):void { getInstance().likeStory(story_id); }
		protected function likeStory(story_id:String):void {
			var likeStory:AddLike = new AddLike(story_id);
			likeStory.addEventListener(FacebookEvent.COMPLETE, onAddLike);
			facebook.post(likeStory);
		}
		
		public static function unlikeStory(story_id:String):void { getInstance().unlikeStory(story_id); }
		protected function unlikeStory(story_id:String):void {
			var unlikeStoryCall:RemoveLike = new RemoveLike(story_id);
			unlikeStoryCall.addEventListener(FacebookEvent.COMPLETE, onRemoveLike);
			facebook.post(unlikeStoryCall);
		}
		
		protected function onRemoveLike(event:FacebookEvent):void {
			dispatchEvent(new StreamEvent(StreamEvent.LIKE_REMOVED, false, false, event.success?event.data:event.error));
		}
		
		protected function onAddLike(event:FacebookEvent):void {
			dispatchEvent(new StreamEvent(StreamEvent.LIKE_ADDED, false, false, event.success?event.data:event.error));
		}
		
		public static function refresh():void { getInstance().refresh(); }
		protected function refresh():void {
			if (getStreamCall != null) { getStreamCall.delegate.close(); }
			
			refreshTimer.stop();
			
			var now:Date = new Date();
			var lastWeek:Date = new Date(now.getTime() - (1000*60*60*24*7));
			
			var nowString:String = FacebookDataUtils.toDateString(now);
			var lastWeekString:String = FacebookDataUtils.toDateString(lastWeek);
			
			getStreamCall = new GetStream(String(FBConnect.session.uid), null, lastWeek, now, 20);
			getStreamCall.addEventListener(FacebookEvent.COMPLETE, onGetStream, false, 0, true);
			facebook.post(getStreamCall);
			
			dispatchEvent(new StreamEvent(StreamEvent.REFRESH));
		}
		
		protected function onGetStream(event:FacebookEvent):void {
			if (event.success == false) {
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_LOAD_ERROR, false, false, event.error));
			} else {
				refreshTimer.reset();
				refreshTimer.start();
				
				lastUpdate = new Date();
				parseResult(event.data as GetStreamData);
			}
		}
		
		protected function parseResult(result:GetStreamData):void {
			var i:uint;
			var l:uint;
			
			var newStoryCount:uint = 0;
			var newAlbumCount:uint = 0;
			var currentStoryData:StreamData;
			
			dataProvider = new ArrayCollection();
			var ssd:StreamData;
			
			l = result.stories.length;
			for (i=0;i<l;i++) {
				var streamStoryData:StreamStoryData = result.stories.getItemAt(i) as StreamStoryData;
				currentStoryData = storyStreamsHash[streamStoryData.post_id];
				
				var message:String = getDisplayMessage(streamStoryData);
				
				if (message != null) {
					ssd = new StreamData(StreamData.STORY);
					ssd.data = streamStoryData;
					ssd.time = streamStoryData.created_time;
					ssd.likeCount = streamStoryData.likes.count;
					ssd.title = '';
					ssd.facebookType = streamStoryData.type;
					ssd.friend = FriendsModel.getFriend(streamStoryData.actor_id);
					ssd.message = message;
					dataProvider.addItem(ssd);
					
					storyStreamsHash[streamStoryData.post_id] = ssd;
					
					if (currentStoryData == null) {
						newStoryCount++;
					} else if (streamStoryData.updated_time > currentStoryData.time) {
						var updateMessage:String = StringUtils.supplant(STREAM_UPDATE_TEXT, {actor:currentStoryData.friend.name, story:StringUtils.truncate(currentStoryData.message, 25)});
					}
				}
			}
			
			var sort:Sort = new Sort();
			sort.fields = [new SortField('updateTime')];
			dataProvider.sort = sort;
			
			dispatchEvent(new StreamEvent(StreamEvent.STREAM_LOAD));
			
			var toastData:NotificationData;
				
			if (newStoryCount != 0) {
				toastData = new NotificationData(newStoryCount + ' stories added.');
			}
		}
		
		protected function getDisplayMessage(value:StreamStoryData):String {
			var message:String = null;
			
			if (value.message != null && StringUtils.trim(value.message) != '') {
				message = value.message;
			} else if (value.message == null && value.attachment != null &&  value.attachment.title != null) {
				message = value.attachment.title + '<br>' + (value.attachment.text == null?value.attachment.body:value.attachment.text);
			}
			
			return message;
		}
		
		public static function getInstance():StreamModel {
			if (_instance == null) { _canInit = true;  _instance = new StreamModel(); _canInit = false; }
			return _instance;
		}
		
	}
}