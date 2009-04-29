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