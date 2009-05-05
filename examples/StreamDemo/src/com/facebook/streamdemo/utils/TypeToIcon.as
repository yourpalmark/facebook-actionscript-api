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
package com.facebook.streamdemo.utils {
	
	import com.facebook.data.stream.StoryType;
	import com.facebook.streamdemo.ui.Assets;
	
	public class TypeToIcon {
		
		public static function getIcon(type:uint):Class {
			var icon:Class
			
			switch (type) {
				case StoryType.CHANGED_PROFILE:
					icon = Assets.changedProfileIcon; break;
				case StoryType.COMMENT:
					icon = Assets.commentIcon; break;
				case StoryType.EVENT:
					icon = Assets.eventIcon; break;
				case StoryType.FAN:
					icon = Assets.fanIcon; break;
				case StoryType.FAN_PAGE:
					icon = Assets.fanPageIcon; break;
				case StoryType.FLICKR:
					icon = Assets.flickrIcon; break;
				case StoryType.GROUP:
					icon = Assets.groupIcon; break;
				case StoryType.JOINED:
					icon = Assets.joinedIcon; break;
				case StoryType.LIKES:
					icon = Assets.likeIcon; break;
				case StoryType.LIKES_POST:
					icon = Assets.likeFadedIcon; break;
				case StoryType.LINK:
					icon = Assets.linkIcon; break;
				case StoryType.MOBILE:
					icon = Assets.mobileIcon; break;
				case StoryType.NOTE:
					icon = Assets.noteIcon; break;
				case StoryType.PHOTO:
					icon = Assets.photoIcon; break;
				case StoryType.POST:
					icon = Assets.postIcon; break;
				case StoryType.POST_NOTE:
					icon = Assets.postNoteIcon; break;
				case StoryType.RELATIONSHIP:
					icon = Assets.relationshipIcon; break;
				case StoryType.TAG:
					icon = Assets.tagIcon; break;
				case StoryType.VIDEO:
					icon = Assets.videoIcon; break;
				case StoryType.YOU_TUBE:
					icon = Assets.youTubeIcon; break;
				case StoryType.CONNECT_SHARE:
					icon = Assets.sharedViaConnectIcon; break;
				case StoryType.ABSENT:
				case StoryType.NO_ICON:
				default:
					icon = Assets.absentIcon; break;
			}
			
			return icon;
		}

	}
}