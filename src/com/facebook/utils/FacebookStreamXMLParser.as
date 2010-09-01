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
package com.facebook.utils {
	
	import com.facebook.data.stream.ActionLinkData;
	import com.facebook.data.stream.AttachmentData;
	import com.facebook.data.stream.CommentsData;
	import com.facebook.data.stream.FlashMedia;
	import com.facebook.data.stream.GetCommentsData;
	import com.facebook.data.stream.GetFiltersData;
	import com.facebook.data.stream.GetStreamData;
	import com.facebook.data.stream.LikesData;
	import com.facebook.data.stream.MusicMedia;
	import com.facebook.data.stream.PhotoMedia;
	import com.facebook.data.stream.PostCommentData;
	import com.facebook.data.stream.ProfileCollection;
	import com.facebook.data.stream.ProfileData;
	import com.facebook.data.stream.StreamFilterCollection;
	import com.facebook.data.stream.StreamFilterData;
	import com.facebook.data.stream.StreamMediaData;
	import com.facebook.data.stream.StreamStoryCollection;
	import com.facebook.data.stream.StreamStoryData;
	import com.facebook.data.stream.VideoMedia;
	
	public class FacebookStreamXMLParser {
		
		public static function createStreamFilterCollection(xml:XML, ns:Namespace):GetFiltersData {
			var gfd:GetFiltersData = new GetFiltersData();
			var ssc:StreamFilterCollection = new StreamFilterCollection();
			
			var filters:XMLList = xml..ns::stream_filter;
			var  l:uint = filters.length();
			for (var i:uint=0;i<l;i++) {
				var filter:XML = filters[i];
				var fd:StreamFilterData = new StreamFilterData();
				fd.filter_key = FacebookXMLParserUtils.toStringValue(filter.ns::filter_key[0]);
				fd.icon_url = FacebookXMLParserUtils.toStringValue(filter.ns::icon_url[0]);
				fd.is_visible = FacebookXMLParserUtils.toBoolean(filter.ns::is_visible[0]);
				fd.name = FacebookXMLParserUtils.toStringValue(filter.ns::name[0]);
				fd.rank = FacebookXMLParserUtils.toNumber(filter.ns::rank[0]);
				fd.type = FacebookXMLParserUtils.toStringValue(filter.ns::type[0]);
				fd.uid = FacebookXMLParserUtils.toStringValue(filter.ns::uid[0]);
				fd.value = FacebookXMLParserUtils.toStringValue(filter.ns::value[0]);
				ssc.addItem(fd);
			}
			
			gfd.filters = ssc;
			return gfd;
		}
		
		public static function createGetCommentsData(source:XML, ns:Namespace):GetCommentsData {
			var postsXML:XMLList = source..ns::comment;
			var gcd:GetCommentsData = new GetCommentsData();
			gcd.comments = createCommentsArray(postsXML, ns);
			return gcd;
		}
		
		public static function createCommentsArray(source:XMLList, ns:Namespace):Array {
			var posts:Array = [];
			var l:uint = source.length();
			for (var i:uint=0;i<l;i++) {
				var c:XML = source[i];
				var comment:PostCommentData = new PostCommentData();
				comment.fromid = FacebookXMLParserUtils.toStringValue(c.ns::fromid[0]);
				comment.id = FacebookXMLParserUtils.toStringValue(c.ns::id[0]);
				comment.text = FacebookXMLParserUtils.toStringValue(c.ns::text[0]);
				comment.time = FacebookXMLParserUtils.toDate(c.ns::time[0]);
				posts.push(comment);
			}
			
			return posts;
		}
		
		public static function createStream(source:XML, ns:Namespace):GetStreamData {
			var gsd:GetStreamData = new GetStreamData();
			var streamStories:StreamStoryCollection = new StreamStoryCollection();
			var profiles:ProfileCollection = new ProfileCollection();
			
			gsd.stories = streamStories;
			gsd.profiles = profiles;
			
			var l:uint;
			var i:uint;
			
			//Parse the stories.
			var storyStreams:XMLList = source.ns::posts.children();
			l = storyStreams.length();
			for (i=0;i<l;i++) {
				var ssx:XML = storyStreams[i];
				var ss:StreamStoryData = new StreamStoryData();
				ss.sourceXML = ssx;
				var attachmentXML:XML = ssx.ns::attachment[0];
				var attachment:AttachmentData = new AttachmentData();
				
				attachment.name =  FacebookXMLParserUtils.toStringValue(attachmentXML.ns::name[0]);
				attachment.text = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::text[0]);
				attachment.body = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::body[0]);
				attachment.icon = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::icon[0]);
				attachment.label = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::label[0]);
				attachment.media = createMediaArray(attachmentXML.ns::media[0], ns);
				attachment.title = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::title[0]);
				attachment.href = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::href[0]);
				attachment.caption = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::caption[0]);
				attachment.description = FacebookXMLParserUtils.toStringValue(attachmentXML.ns::description[0]);
				attachment.properties = FacebookXMLParserUtils.xmlListToObjectArray(attachmentXML..ns::stream_property);
				
				ss.attachment = attachment;
				
				ss.actor_id = FacebookXMLParserUtils.toStringValue(ssx.ns::actor_id[0]);
				ss.comments = createComments(ssx.ns::comments[0], ns);
				
				var likesData:LikesData = new LikesData();
				var likesXML:XML = ssx.ns::likes[0];
				 
				likesData.can_like = FacebookXMLParserUtils.toBoolean(likesXML.ns::can_like[0]);
				likesData.user_likes = FacebookXMLParserUtils.toBoolean(likesXML.ns::user_likes[0]);
				likesData.count = FacebookXMLParserUtils.toNumber(likesXML.ns::count[0]);
				likesData.friends = FacebookXMLParserUtils.toUIDArray(likesXML.ns::friends[0]);
				likesData.sample = FacebookXMLParserUtils.toUIDArray(likesXML.ns::sample[0]);
				likesData.href = FacebookXMLParserUtils.toStringValue(likesXML.ns::href[0]);
				ss.likes = likesData;
				
				ss.attribution = FacebookXMLParserUtils.toStringValue(ssx.ns::attribution[0]);
				ss.app_id = FacebookXMLParserUtils.toStringValue(ssx.ns::app_id[0]);
				ss.metadata = FacebookXMLParserUtils.nodeToObject(ssx.ns::metadata);
				ss.message = FacebookXMLParserUtils.toStringValue(ssx.ns::message[0]);
				ss.source_id = FacebookXMLParserUtils.toStringValue(ssx.ns::source_id[0]);
				ss.target_id = FacebookXMLParserUtils.toStringValue(ssx.ns::target_id[0]);
				ss.post_id = FacebookXMLParserUtils.toStringValue(ssx.ns::post_id[0]);
				ss.updated_time = FacebookXMLParserUtils.toDate(ssx.ns::updated_time[0]);
				ss.created_time = FacebookXMLParserUtils.toDate(ssx.ns::created_time[0]);
				ss.type = FacebookXMLParserUtils.toNumber(ssx.ns::type[0]);
				ss.viewer_id = FacebookXMLParserUtils.toStringValue(ssx.ns::viewer_id[0]);
				
				var privacy:XML = ssx.ns::privacy[0];
				ss.privacy = FacebookXMLParserUtils.toStringValue(privacy.ns::value[0]);
				ss.filter_key = FacebookXMLParserUtils.toStringValue(ssx.ns::filter_key[0]);
				ss.permalink = FacebookXMLParserUtils.toStringValue(ssx.ns::permalink[0]);
				ss.is_hidden = FacebookXMLParserUtils.toBoolean(ssx.ns::is_hidden[0]);
				ss.action_links = createActionLinksArray(ssx.ns::action_links[0], ns);
				
				streamStories.addItem(ss);
			}
			
			//Parse Profiles
			var profilesXml:XMLList = source.ns::profiles.children();
			l = profilesXml.length();
			for (i=0;i<l;i++) {
				var profile:ProfileData = new ProfileData();
				var profXml:XML = profilesXml[i];
				profile.id = FacebookXMLParserUtils.toStringValue(profXml.ns::id[0]);
				profile.name = FacebookXMLParserUtils.toStringValue(profXml.ns::name[0]);
				profile.pic_square = FacebookXMLParserUtils.toStringValue(profXml.ns::pic_square[0]);
				profile.url = FacebookXMLParserUtils.toStringValue(profXml.ns::url[0]);
				profiles.addItem(profile);
			}
			
			//Parse Albums
			gsd.albums = FacebookXMLParserUtils.createAlbumCollection(source.ns::albums[0], ns);
			
			return gsd;
		}
		
		protected static function createMediaArray(value:XML, ns:Namespace):Array {
			if (value == null) { return null; }
			
			var arr:Array = [];
			var media:XMLList = value.children();
			var l:uint = media.length();
			for (var i:uint=0;i<l;i++) {
				var mediaXML:XML = media[i];
				var smd:StreamMediaData = new StreamMediaData();
				smd.type = FacebookXMLParserUtils.toStringValue(mediaXML.ns::type[0]);
				smd.alt = FacebookXMLParserUtils.toStringValue(mediaXML.ns::alt[0]);
				smd.href = FacebookXMLParserUtils.toStringValue(mediaXML.ns::href[0]);
				smd.src = FacebookXMLParserUtils.toStringValue(mediaXML.ns::src[0]);
				smd.video = createVideoMedia(mediaXML.ns::video[0], ns);
				smd.photo = createPhotoMedia(mediaXML.ns::photo[0], ns);
				smd.flash = createFlashMedia(mediaXML.ns::swf[0], ns);
				smd.music = createMusicMedia(mediaXML.ns::music[0], ns);
				arr.push(smd);
			}
			
			return arr;
		}
		
		protected static function createVideoMedia(value:XML, ns:Namespace):VideoMedia {
			if (value == null) { return null; }
			var vm:VideoMedia = new VideoMedia();
			vm.display_url = FacebookXMLParserUtils.toStringValue(value.ns::display_url[0]);
			vm.owner = FacebookXMLParserUtils.toStringValue(value.ns::owner[0]);
			vm.permalink = FacebookXMLParserUtils.toStringValue(value.ns::permalink[0]);
			vm.source_url = FacebookXMLParserUtils.toStringValue(value.ns::source_url[0]);
			vm.preview_img = FacebookXMLParserUtils.toStringValue(value.ns::preview_img[0]);
			return vm;
		}
		
		protected static function createPhotoMedia(value:XML, ns:Namespace):PhotoMedia {
			if (value == null) { return null; }
			
			var pm:PhotoMedia = new PhotoMedia();
			pm.aid = FacebookXMLParserUtils.toStringValue(value.ns::aid[0]);
			pm.index = FacebookXMLParserUtils.toNumber(value.ns::index[0]);
			pm.owner = FacebookXMLParserUtils.toStringValue(value.ns::owner[0]);
			pm.pid = FacebookXMLParserUtils.toStringValue(value.ns::pid[0]);
			return pm;
		}
		
		protected static function createFlashMedia(value:XML, ns:Namespace):FlashMedia {
			if (value == null) { return null; }
			
			var fm:FlashMedia = new FlashMedia();
			fm.source_url = FacebookXMLParserUtils.toStringValue(value.ns::source_url[0]);
			fm.preview_img = FacebookXMLParserUtils.toStringValue(value.ns::preview_img[0]);
			return fm;
		}
		
		protected static function createMusicMedia(value:XML, ns:Namespace):MusicMedia {
			if (value == null) { return null; }
			
			var mm:MusicMedia= new MusicMedia();
			mm.source_url = FacebookXMLParserUtils.toStringValue(value.ns::source_url[0]);
			mm.artist = FacebookXMLParserUtils.toStringValue(value.ns::artist[0]);
			mm.title= FacebookXMLParserUtils.toStringValue(value.ns::title[0]);
			return mm; 
		}
		
		protected static function createComments(source:XML, ns:Namespace):CommentsData {
			var comments:CommentsData = new CommentsData();
			 
			comments.can_remove = FacebookXMLParserUtils.toBoolean(source.ns::can_remove[0]);
			comments.can_post = FacebookXMLParserUtils.toBoolean(source.ns::can_post[0]);
			comments.count = FacebookXMLParserUtils.toNumber(source.ns::count[0]);
			
			var postsXML:XMLList = source.ns::comment_list.children();
			comments.posts = createCommentsArray(postsXML, ns);
			return comments;
		}
		
		protected static function createActionLinksArray(value:XML, ns:Namespace):Array {
			if (value == null) { return null; }
			
			var arr:Array = [];
			var links:XMLList = value.children();
			var l:uint = links.length();
			for (var i:uint=0;i<l;i++) {
				var linkXML:XML = links[i];
				var ald:ActionLinkData = new ActionLinkData();
				ald.text = FacebookXMLParserUtils.toStringValue(linkXML.ns::text[0]);
				ald.href = FacebookXMLParserUtils.toStringValue(linkXML.ns::href[0]);
				arr.push(ald);
			}
			
			return arr;
		}

	}
}