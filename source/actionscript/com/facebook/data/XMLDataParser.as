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
package com.facebook.data {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.commands.data.GetCookiesData;
	import com.facebook.data.admin.GetAllocationData;
	import com.facebook.data.admin.GetAppPropertiesData;
	import com.facebook.data.admin.GetMetricsData;
	import com.facebook.data.admin.MetricsData;
	import com.facebook.data.admin.MetricsDataCollection;
	import com.facebook.data.application.GetPublicInfoData;
	import com.facebook.data.auth.GetSessionData;
	import com.facebook.data.batch.BatchResult;
	import com.facebook.data.data.GetObjectTypeData;
	import com.facebook.data.data.GetObjectTypesData;
	import com.facebook.data.data.GetUserPreferencesData;
	import com.facebook.data.data.ObjectTypesCollection;
	import com.facebook.data.data.ObjectTypesData;
	import com.facebook.data.data.PreferenceCollection;
	import com.facebook.data.data.PreferenceData;
	import com.facebook.data.events.EventCollection;
	import com.facebook.data.events.EventData;
	import com.facebook.data.events.GetEventsData;
	import com.facebook.data.events.GetMembersData;
	import com.facebook.data.fbml.AbstractTagData;
	import com.facebook.data.fbml.ContainerTagData;
	import com.facebook.data.fbml.GetCustomTagsData;
	import com.facebook.data.fbml.LeafTagData;
	import com.facebook.data.fbml.TagCollection;
	import com.facebook.data.feed.GetRegisteredTemplateBundleByIDData;
	import com.facebook.data.feed.GetRegisteredTemplateBundleData;
	import com.facebook.data.feed.TemplateBundleCollection;
	import com.facebook.data.feed.TemplateCollection;
	import com.facebook.data.feed.TemplateData;
	import com.facebook.data.friends.AreFriendsData;
	import com.facebook.data.friends.FriendsCollection;
	import com.facebook.data.friends.FriendsData;
	import com.facebook.data.friends.GetAppUserData;
	import com.facebook.data.friends.GetFriendsData;
	import com.facebook.data.friends.GetListsData;
	import com.facebook.data.friends.ListsData;
	import com.facebook.data.groups.GetGroupData;
	import com.facebook.data.groups.GetMemberData;
	import com.facebook.data.groups.GroupCollection;
	import com.facebook.data.groups.GroupData;
	import com.facebook.data.notes.GetNotesData;
	import com.facebook.data.notes.NoteData;
	import com.facebook.data.notes.NotesCollection;
	import com.facebook.data.notifications.GetNotificationData;
	import com.facebook.data.notifications.NotificationCollection;
	import com.facebook.data.notifications.NotificationMessageData;
	import com.facebook.data.notifications.NotificationPokeData;
	import com.facebook.data.notifications.NotificationShareData;
	import com.facebook.data.pages.GetPageInfoData;
	import com.facebook.data.pages.PageInfoCollection;
	import com.facebook.data.pages.PageInfoData;
	import com.facebook.data.photos.AlbumData;
	import com.facebook.data.photos.FacebookPhoto;
	import com.facebook.data.photos.GetAlbumsData;
	import com.facebook.data.photos.GetCreateAlbumData;
	import com.facebook.data.photos.GetPhotosData;
	import com.facebook.data.photos.GetTagsData;
	import com.facebook.data.photos.PhotoCollection;
	import com.facebook.data.photos.PhotoData;
	import com.facebook.data.photos.PhotoTagCollection;
	import com.facebook.data.photos.TagData;
	import com.facebook.data.status.GetStatusData;
	import com.facebook.data.status.Status;
	import com.facebook.data.users.AffiliationCollection;
	import com.facebook.data.users.AffiliationData;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.FacebookUserCollection;
	import com.facebook.data.users.GetInfoData;
	import com.facebook.data.users.GetStandardInfoData;
	import com.facebook.data.users.UserCollection;
	import com.facebook.data.users.UserData;
	import com.facebook.errors.FacebookError;
	import com.facebook.utils.FacebookStreamXMLParser;
	import com.facebook.utils.FacebookUserXMLParser;
	import com.facebook.utils.FacebookXMLParserUtils;
	import com.facebook.utils.IFacebookResultParser;
	
	import flash.events.ErrorEvent;
	
	public class XMLDataParser implements IFacebookResultParser {
		
		protected var fb_namespace:Namespace;
		
		public function XMLDataParser() {
			fb_namespace = new Namespace("http://api.facebook.com/1.0/");
		}
		
		public function parse(data:String, methodName:String):FacebookData {
			var result:FacebookData;
			var xml:XML = new XML(data);
		
			switch (methodName) {
				case 'application.getPublicInfo':
					result = parseGetPublicInfo(xml); break;
				case 'data.getCookies':
					result = parseGetCookies(xml); break; 
				case 'admin.getAllocation':
					result = parseGetAllocation(xml); break;
				case 'admin.getAppProperties':
					result = parseGetAppProperties(xml); break;
				case 'admin.getMetrics':
					result = parseGetMetrics(xml); break;
				case 'auth.getSession':
					result = new GetSessionData();
					(result as GetSessionData).expires = FacebookXMLParserUtils.toDate(xml.fb_namespace::expires);
					(result as GetSessionData).uid = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::uid[0]);
					(result as GetSessionData).session_key = xml.fb_namespace::session_key.toString();
					(result as GetSessionData).secret = String(xml.fb_namespace::secret);
					break;
				case 'feed.getRegisteredTemplateBundles': 
					result = parseGetRegisteredTemplateBundles(xml); break;
				case 'friends.areFriends':
					result = parseAreFriends(xml); break;
				case 'notes.get':
					result = parseGetNotes(xml); break;
				case 'friends.get':
					result = parseGetFriends(xml); break;
				case 'friends.getAppUsers':
					result = parseGetAppUsersData(xml); break;
				case 'friends.getLists':
					result = parseGetLists(xml); break;
				case 'groups.get':
					result = parseGetGroups(xml); break;
				case 'data.getAssociationDefinitions':
					result = new FacebookData(); break;
				case 'data.getAssociationDefinition':
					result = new FacebookData(); break;
				case 'data.getObject':
				case 'data.getObjects':
					result = new FacebookData(); break;
				case 'groups.getMembers':
					result = parseGetGroupMembers(xml); break;
				case 'users.getInfo':
					result = parseGetInfo(xml); break;
				case 'data.createObject':
				case 'data.setHashValue':
				case 'connect.getUnconnectedFriendsCount':
				case 'feed.registerTemplateBundle':
					result = new NumberResultData();
					(result as NumberResultData).value = FacebookXMLParserUtils.toNumber(xml); break;
				case 'notifications.get':
					result = parseGetNotifications(xml); break;
				case 'feed.getRegisteredTemplateBundleByID':
					result = parseGetRegisteredTemplateBundleByID(xml); break;
				case 'users.getStandardInfo':
					result = parseGetStandardInfo(xml); break;
				case 'feed.getRegisteredTemplateBundles':
					result = parseGetRegisteredTemplateBundles(xml); break;
				case 'data.getUserPreferences':
					result = parseGetUserPreferences(xml); break;
				case 'users.isAppUser':
				case 'users.hasAppPermission':
				case 'users.setStatus':
				case 'pages.isFan':
				case 'pages.isAppAdded':
				case 'pages.isAdmin':
				case 'admin.setAppProperties':
				case 'auth.expireSession':
				case 'auth.revokeAuthorization':
				case 'events.cancel':
				case 'events.edit':
				case 'events.rsvp':
				case 'liveMessage.send':
				case 'data.undefineAssociation':
				case 'data.defineAssociation':
				case 'data.removeHashKeys':
				case 'data.removeHashKey':
				case 'data.incHashValue':
				case 'data.updateObject':
				case 'data.deleteObject':
				case 'data.deleteObjects':
				case 'data.renameAssociation':
				case 'data.setObjectProperty':
				case 'profile.setInfo':
				case 'profile.setInfoOptions':
				case 'feed.deactivateTemplateBundleByID':
				case 'feed.publishTemplatizedAction':
				case 'admin.setRestrictionInfo':
				case 'data.setCookie':
				case 'data.createObjectType':
				case 'notes.delete':
				case 'notes.edit':
				case 'data.setUserPreference':
				case 'data.dropObjectType':
				case 'data.renameObjectType':
				case 'fbml.registerCustomTags':
				case 'fbml.deleteCustomTags':
				case 'fbml.refreshRefUrl':
				case 'fbml.refreshImgSrc':
				case 'fbml.setRefHandle':
				case 'data.setUserPreferences':
				case 'data.defineObjectProperty':
				case 'photos.addTag':
				case 'stream.addLike':
				case 'stream.removeLike':
				case 'stream.removeComment':
				case 'sms.canSend':
					result = new BooleanResultData();
					(result as BooleanResultData).value = FacebookXMLParserUtils.toBoolean(xml); break;
				case 'feed.publishUserAction':
					result = new BooleanResultData();
					(result as BooleanResultData).value = FacebookXMLParserUtils.toBoolean(xml.children()[0]);
					break;
				case 'notifications.sendEmail':
					result = parseSendEmail(xml); break;
				case 'data.getObjectTypes':
					result = parseGetObjectTypes(xml); break;
				case 'users.getStandardInfo':
					result = parseGetStandardInfo(xml); break;
				case 'data.getObjectType':
					result = parseGetObjectType(xml); break;
				case 'events.get':
					result = parseGetEvent(xml); break;
				case 'events.getMembers':
					result = parseGetMembers(xml); break;
				case 'fql.multiquery':
					result = new FacebookData(); break;
				case 'fql.query':
					result = new FacebookData(); break;
				case 'photos.createAlbum':
					result = parseCreateAlbum(xml); break;
				case 'photos.get': 
					result = parseGetPhotos(xml); break;
				case 'photos.getTags': 
					result = parseGetTags(xml); break;
				case 'photos.getAlbums':
					result = parseGetAlbums(xml); break;
				case 'photos.upload':
					result = parseFacebookPhoto(xml); break;
				case 'pages.getInfo':
					result = parsePageGetInfo(xml); break;
				case 'batch.run':
					result = parseBatchRun(xml); break;
				case 'fbml.getCustomTags':
					result = parseGetCustomTags(xml); break;
				case 'connect.unregisterUsers':
				case 'connect.registerUsers':
					result = new ArrayResultData();
					(result as ArrayResultData).arrayResult = FacebookXMLParserUtils.toArray(xml); break;
				case 'status.get':
					result = parseGetStatus(xml); break;
				case 'stream.get':
					result = FacebookStreamXMLParser.createStream(xml, fb_namespace); break;
				case 'stream.getComments':
					result = FacebookStreamXMLParser.createGetCommentsData(xml, fb_namespace); break;
				case 'stream.getFilters':
					result = FacebookStreamXMLParser.createStreamFilterCollection(xml, fb_namespace); break;
				case 'auth.createToken':
				case 'events.create':
				case 'links.post':
				case 'auth.promoteSession':
				case 'admin.getRestrictionInfo':
				case 'data.getObjectProperty':
				case 'notifications.send':
				case 'notes.create':
				case 'data.getUserPreference':
				case 'profile.setFBML':
				case 'users.getLoggedInUser':
				case 'stream.addComment':
				default:
					result = new StringResultData();
					(result as StringResultData).value = FacebookXMLParserUtils.toStringValue(xml);
					break;
			}
			
			result.rawResult = data;
			return result;
		}
		
		protected function parseGetStatus(xml:XML):GetStatusData {
			var gsd:GetStatusData =  new GetStatusData();
			var status:Array = [];
			
			var children:XMLList = xml.children();
			var l:uint = children.length();
			for (var i:uint=0;i<l;i++) {
				var statusXML:XML = children[i];
				var statusNode:Status = new Status();
				statusNode.uid = FacebookXMLParserUtils.toStringValue(statusXML.fb_namespace::uid[0]);
				statusNode.status_id = FacebookXMLParserUtils.toStringValue(statusXML.fb_namespace::status_id[0]);
				statusNode.time = FacebookXMLParserUtils.toDate(statusXML.fb_namespace::time[0]);
				statusNode.source = FacebookXMLParserUtils.toStringValue(statusXML.fb_namespace::source[0]);
				statusNode.message = FacebookXMLParserUtils.toStringValue(statusXML.fb_namespace::message[0]);
				
				status.push(statusNode);
			}
			
			gsd.status = status;
			
			return gsd;
		}
		
		protected function parseGetInfo(xml:XML):GetInfoData {
			var collection:FacebookUserCollection = new FacebookUserCollection();
			var users:XMLList = xml..fb_namespace::user;
			var l:uint = users.length();
			for (var i:uint = 0;i<l;i++) {
				var user:FacebookUser = FacebookUserXMLParser.createFacebookUser(users[i], fb_namespace);
				collection.addItem(user);
			}
			var data:GetInfoData = new GetInfoData();
			data.userCollection = collection;
			return data;
		}
		
		protected function parseGetCustomTags(xml:XML):GetCustomTagsData {
			var propList:Array = ['type','name','open_tag_fbml','description','close_tag_fbml','is_public','attributes','header_fbml','footer_fbml','fbml'];
			var getCustomTagsData:GetCustomTagsData = new GetCustomTagsData();
			var tagCollection:TagCollection = new TagCollection();
			for each(var tag:* in xml..fb_namespace::custom_tag) {
				tagCollection.addItem(createTagObject(tag, propList));
			}
			getCustomTagsData.tagCollection = tagCollection;
			return getCustomTagsData;
		}
		
		protected function createTagObject(xml:XML, propList:Array):* {
			var l:Number = xml.children().length();
			var type:String =  xml.children()[0].toLowerCase();
			var tagData:AbstractTagData;
			if (type == 'leaf') { 
				tagData = new LeafTagData(null, null ,null, null, null);
				(tagData as LeafTagData).fbml = xml.children()[9];
			}else {
				tagData = new ContainerTagData(null,null,null,null,null,null,null);
				(tagData as ContainerTagData).open_tag_fbml = xml.children()[2];
				(tagData as ContainerTagData).close_tag_fbml = xml.children()[4];
			}
			
			for(var i:Number=0;i<l;i++) {
				var value:Object =  xml.children()[i];
				switch(propList[i]) {
					case 'name':
					case 'type':
					//case 'open_tag_fbml':
					case 'description':
					//case 'close_tag_fbml':
					case 'is_public':
					case 'header_fbml':
					case 'footer_fbml':
					//case 'fbml':
						tagData[propList[i]] = value.text();
						break;
					case 'attributes':
						if (value.children() is XMLList) {
							if (value.children().length() == 0) {
								tagData[propList[i]] = null;
							}
						}
						break;
				}
			}
			return tagData;
		}
		
		protected function parseGetUserPreferences(xml:XML):GetUserPreferencesData {
			var getUserPreferenceData:GetUserPreferencesData = new GetUserPreferencesData();
			var preferenceCollection:PreferenceCollection = new PreferenceCollection();
			for each(var pref:* in xml..fb_namespace::preference) {
				var pd:PreferenceData = new PreferenceData();
				pd.pref_id = pref.fb_namespace::pref_id;
				pd.value = pref.fb_namespace::value;
				preferenceCollection.addItem(pd);
			}
			getUserPreferenceData.perferenceCollection = preferenceCollection;
			return getUserPreferenceData;
		}
		
		protected function parseGetNotes(xml:XML):GetNotesData {
			var getNotesData:GetNotesData = new GetNotesData();
			var notesCollection:NotesCollection = new NotesCollection();
			for each(var note:* in xml..fb_namespace::note) {
				var noteData:NoteData = new NoteData();
				noteData.note_id = note.fb_namespace::note_id;
				noteData.title = note.fb_namespace::title;
				noteData.content = note.fb_namespace::content;
				noteData.created_time = FacebookXMLParserUtils.toDate(note.fb_namespace::created_time);
				noteData.updated_time = FacebookXMLParserUtils.toDate(note.fb_namespace::updated_time);
				noteData.uid = note.fb_namespace::uid;
				notesCollection.addItem(noteData);
			}
			getNotesData.notesCollection = notesCollection;
			return getNotesData;
		}
		
		protected function parseGetCookies(xml:XML):GetCookiesData {
			var getCookiesData:GetCookiesData = new GetCookiesData();
			getCookiesData.uid = xml.fb_namespace::uid;
			getCookiesData.name = xml.fb_namespace::name;
			getCookiesData.value = xml.fb_namespace::value;
			getCookiesData.expires = xml.fb_namespace::expires;
			getCookiesData.path = xml.fb_namespace::path;
			return getCookiesData;
		}
		
		protected function parseGetPublicInfo(xml:XML):GetPublicInfoData {
			var getPageInfoData:GetPublicInfoData = new GetPublicInfoData();
			getPageInfoData.app_id = xml.fb_namespace::app_id;
			getPageInfoData.api_key = xml.fb_namespace::api_key;
			getPageInfoData.canvas_name = xml.fb_namespace::canvas_name;
			getPageInfoData.display_name = xml.fb_namespace::display_name;
			getPageInfoData.icon_url = xml.fb_namespace::icon_url;
			getPageInfoData.logo_url = xml.fb_namespace::logo_url;
			getPageInfoData.developers = xml.fb_namespace::developers;
			getPageInfoData.company_name = xml.fb_namespace::company_name;
			getPageInfoData.developers = xml.fb_namespace::developers;
			getPageInfoData.daily_active_users = xml.fb_namespace::daily_active_users;
			getPageInfoData.weekly_active_users = xml.fb_namespace::weekly_active_users;
			getPageInfoData.monthly_active_users = xml.fb_namespace::monthly_active_users;
			getPageInfoData.description = xml.fb_namespace::description;
			
			return getPageInfoData;
		}
		
		protected function parseGetRegisteredTemplateBundles(xml:XML):GetRegisteredTemplateBundleData {
			var bundleData:GetRegisteredTemplateBundleData = new GetRegisteredTemplateBundleData();
			var bundleCollection:TemplateBundleCollection = new TemplateBundleCollection();
			var templateCollection:TemplateCollection = new TemplateCollection();
			for each(var tempBundle:* in xml..fb_namespace::template_bundle) {
				getTemplate(tempBundle.fb_namespace::one_line_story_template, templateCollection);
				getTemplate(tempBundle.fb_namespace::short_story_templates, templateCollection);
				getTemplate(tempBundle.fb_namespace::full_story_template, templateCollection);
			
				templateCollection.template_bundle_id = tempBundle.fb_namespace::template_bundle_id;
				templateCollection.time_created = FacebookXMLParserUtils.toDate(tempBundle.fb_namespace::time_created);
			}
			
			bundleData.bundleCollection = templateCollection;
			return bundleData;
		}
		
		protected function getTemplate(xml:XMLList, templateCollection:TemplateCollection):void {
			for each(var temp:* in xml) {
				var tmpData:TemplateData = new TemplateData();
				tmpData.type = temp.localName();
				tmpData.template_body = temp.fb_namespace::template_body;
				tmpData.template_title = temp.fb_namespace::template_title;
				templateCollection.addTemplateData(tmpData);
			}
		}
		
		
		protected function parseGetRegisteredTemplateBundleByID(xml:XML):GetRegisteredTemplateBundleByIDData {
			var getTemplateData:GetRegisteredTemplateBundleByIDData = new GetRegisteredTemplateBundleByIDData();
			var templateCollection:TemplateCollection = new TemplateCollection();
			
			getTemplate(xml.fb_namespace::one_line_story_template, templateCollection);
			getTemplate(xml.fb_namespace::short_story_templates, templateCollection);
			getTemplate(xml.fb_namespace::full_story_template, templateCollection);
			templateCollection.template_bundle_id = xml.fb_namespace::template_bundle_id;
			templateCollection.time_created = FacebookXMLParserUtils.toDate(xml.fb_namespace::time_created);
			
			getTemplateData.templateCollection = templateCollection;
			
			return getTemplateData;
		}
		
		protected function parseGetStandardInfo(xml:XML):GetStandardInfoData {
			var getStandardData:GetStandardInfoData = new GetStandardInfoData();
			var userCollection:UserCollection = new UserCollection();
			
			for each(var user:* in xml..fb_namespace::user) {
				var userData:UserData = new UserData();
				userData.uid = user.fb_namespace::uid;
				userData.affiations = getAffiliation(XML(user.fb_namespace::affiliations.toXMLString())); //userData.affiations = getAffiliation(user.fb_namespace::affiliations);
				userData.first_name = user.fb_namespace::first_name;
				userData.last_name = user.fb_namespace::last_name;
				userData.name = user.fb_namespace::name;
				userData.timezone = user.fb_namespace::timezone;
				userCollection.addItem(userData);
			}
			getStandardData.userCollection = userCollection;
			return getStandardData;
		}
		
		protected function parseGetMetrics(xml:XML):GetMetricsData {
			var getMetricsData:GetMetricsData = new GetMetricsData();
			var metrixCollection:MetricsDataCollection = new MetricsDataCollection();
			for each(var metrix:* in xml..fb_namespace::metrics) {
				var metrixData:MetricsData = new MetricsData();
				metrixData.end_time = FacebookXMLParserUtils.toDate(metrix.fb_namespace::end_time);
				metrixData.active_users = metrix.fb_namespace::active_users;
				metrixData.canvas_page_views = metrix.fb_namespace::canvas_page_views;
				metrixCollection.addItem(metrixData);
			} 
			
			getMetricsData.metricsCollection = metrixCollection;
			return getMetricsData;
		}
		
		protected function parseSendEmail(xml:XML):ArrayResultData {
			var arr:ArrayResultData = new ArrayResultData();
			arr.arrayResult = FacebookXMLParserUtils.toArray(xml);
			return arr;
		}
		
		protected function parseGetMembers(xml:XML):GetMembersData {
			var getMembersData:GetMembersData = new GetMembersData();
			getMembersData.attending = FacebookXMLParserUtils.toUIDArray(xml..fb_namespace::attending[0]);
			getMembersData.unsure = FacebookXMLParserUtils.toUIDArray(xml..fb_namespace::unsure[0]);
			getMembersData.declined = FacebookXMLParserUtils.toUIDArray(xml..fb_namespace::declined[0]);
			getMembersData.not_replied = FacebookXMLParserUtils.toUIDArray(xml..fb_namespace::not_replied[0]);
			
			return getMembersData;
		}
		
		protected function parseGetLists(xml:XML):GetListsData {
			var getListData:GetListsData = new GetListsData();
			var friendsLists:Array = [];
			for each(var list:* in xml..fb_namespace::friendlist) {
				var listData:ListsData = new ListsData();
				listData.flid = list.fb_namespace::flid;
				listData.name = list.fb_namespace::name;
				friendsLists.push(listData);
			}
			
			getListData.lists = friendsLists;
			return getListData;
		}
		
		protected function parseGetEvent(xml:XML):GetEventsData {
			var getEventsData:GetEventsData = new GetEventsData();
			var eventCollection:EventCollection = new EventCollection();
			
			for each(var event:* in xml..fb_namespace::event) {
				var eventData:EventData = new EventData();
				eventData.eid = event.fb_namespace::eid;
				eventData.name = event.fb_namespace::name;
				eventData.tagline = event.fb_namespace::tagline;
				eventData.nid = event.fb_namespace::nid;
				eventData.pic = event.fb_namespace::pic;
				eventData.pic_big = event.fb_namespace::pic_big;
				eventData.pic_small = event.fb_namespace::pic_small;
				eventData.host = event.fb_namespace::host;
				eventData.description = event.fb_namespace::description;
				eventData.event_type = event.fb_namespace::event_type;
				eventData.event_subtype = event.fb_namespace::event_subtype;
				eventData.start_time = FacebookXMLParserUtils.toDate(event.fb_namespace::start_time);
				eventData.end_time = FacebookXMLParserUtils.toDate(event.fb_namespace::end_time);
				eventData.creator = event.fb_namespace::end_time;
				eventData.update_time = FacebookXMLParserUtils.toDate(event.fb_namespace::update_time);
				eventData.location = event.fb_namespace::location;
				eventData.venue = FacebookXMLParserUtils.createLocation(event.fb_namespace::venue[0], fb_namespace);
				eventCollection.addItem(eventData);
			}
			getEventsData.eventCollection = eventCollection;
			
			return getEventsData;
		}
		
		protected function parseGetObjectType(xml:XML):GetObjectTypeData {
			var getObjectTypeData:GetObjectTypeData = new GetObjectTypeData();
			getObjectTypeData.name = xml.fb_namespace::name;
			getObjectTypeData.data_type = xml.fb_namespace::data_type;
			getObjectTypeData.index_type = xml.fb_namespace::index_type;
			
			return getObjectTypeData;
		}
		
		protected function parseGetObjectTypes(xml:XML):GetObjectTypesData {
			var getObjectTypesData:GetObjectTypesData = new GetObjectTypesData();
			var objectTypeCollection:ObjectTypesCollection = new ObjectTypesCollection();
			for each(var info:* in xml..fb_namespace::object_type_info) {
				var objectTypeData:ObjectTypesData = new ObjectTypesData();
				objectTypeData.name = info.fb_namespace::name;
				objectTypeData.object_class = info.fb_namespace::object_class;
				objectTypeCollection.addItem(objectTypeData);
			}
			getObjectTypesData.objectTypeCollection = objectTypeCollection;
			
			return getObjectTypesData;
		}
		
		protected function parseCreateAlbum(xml:XML):GetCreateAlbumData {
			var getCreateAlbum:GetCreateAlbumData = new GetCreateAlbumData();
			var ad:AlbumData = new AlbumData();
			
			ad.aid = xml.fb_namespace::aid;
			ad.cover_pid = xml.fb_namespace::cover_pid;
			ad.owner = xml.fb_namespace::owner;
			ad.name = xml.fb_namespace::name;
			ad.created = FacebookXMLParserUtils.toDate(xml.fb_namespace::created);
			ad.modified = FacebookXMLParserUtils.toDate(xml.fb_namespace::modified);
			ad.description = xml.fb_namespace::description;
			ad.location = xml.fb_namespace::location;
			ad.link = xml.fb_namespace::link;
			ad.size = xml.fb_namespace::size;
			ad.visible = xml.fb_namespace::visible;
			getCreateAlbum.albumData  = ad;
			
			return getCreateAlbum;
		}
		
		protected function parseGetPhotos(xml:XML):GetPhotosData {
			var getPhotosData:GetPhotosData = new GetPhotosData();
			var photoCollection:PhotoCollection = new PhotoCollection();
			for each(var photo:* in xml..fb_namespace::photo) {
				var photoData:PhotoData = new PhotoData();
				photoData.pid = photo.fb_namespace::pid;
				photoData.aid = photo.fb_namespace::aid;
				photoData.owner = photo.fb_namespace::owner;
				photoData.src = photo.fb_namespace::src;
				photoData.src_big = photo.fb_namespace::src_big;
				photoData.src_small = photo.fb_namespace::src_small;
				photoData.caption = photo.fb_namespace::caption;
				photoData.created = FacebookXMLParserUtils.toDate(photo.fb_namespace::created);
				photoCollection.addPhoto(photoData);
			}
			getPhotosData.photoCollection = photoCollection;
			return getPhotosData;
			
		}
		
		protected function parseGetAlbums(xml:XML):GetAlbumsData {
			var getAlbumsData:GetAlbumsData = new GetAlbumsData();
			getAlbumsData.albumCollection = FacebookXMLParserUtils.createAlbumCollection(xml, fb_namespace);
			return getAlbumsData;
		}
		
		protected function parseGetTags(xml:XML):GetTagsData {
			var getTagsData:GetTagsData = new GetTagsData();
			var photoTagCollection:PhotoTagCollection = new PhotoTagCollection();
			
			for each(var photoTag:* in xml..fb_namespace::photo_tag) {
				var tagData:TagData = new TagData();
				tagData.text = photoTag.fb_namespace::text;
				tagData.pid = photoTag.fb_namespace::pid;
				tagData.subject = photoTag.fb_namespace::subject;
				tagData.xcoord = photoTag.fb_namespace::xcoord;
				tagData.ycoord = photoTag.fb_namespace::ycoord;
				tagData.created = FacebookXMLParserUtils.toDate(photoTag.fb_namespace::created);
				photoTagCollection.addPhotoTag(tagData);
			}
			
			getTagsData.photoTagsCollection = photoTagCollection;
			return getTagsData;
			
		}
		
		protected function parsePageGetInfo(xml:XML):GetPageInfoData {
			var getPageInfoData:GetPageInfoData = new GetPageInfoData();
			var pageInfoCollection:PageInfoCollection = new PageInfoCollection();
			
			var pages:XMLList = xml.fb_namespace::page;
			
			for each(var page:Object in pages) {
				var pageInfoData:PageInfoData = new PageInfoData();
				
				pageInfoData.page_id = page.fb_namespace::page_id;
				pageInfoData.name = page.fb_namespace::name;
				pageInfoData.pic_small = page.fb_namespace::pic_small;
				pageInfoData.pic_big = page.fb_namespace::pic_big;
				pageInfoData.pic_square = page.fb_namespace::pic_square;
				pageInfoData.pic_large = page.fb_namespace::pic_large;
				pageInfoData.type = page.fb_namespace:: type;
				pageInfoData.website = page.fb_namespace::website;
				pageInfoData.location = FacebookXMLParserUtils.createLocation(page.fb_namespace::location[0], fb_namespace);
				pageInfoData.hours = page.fb_namespace::hours;
				pageInfoData.band_members = page.fb_namespace::band_members;
				pageInfoData.bio = page.fb_namespace::bio;
				pageInfoData.hometown = page.fb_namespace::hometown;
				pageInfoData.genre = FacebookXMLParserUtils.toStringValue(page.fb_namespace::genre[0]);
				pageInfoData.record_label = page.fb_namespace::record_label;
				pageInfoData.influences = page.fb_namespace::influences;
				pageInfoData.has_added_app = FacebookXMLParserUtils.toBoolean(page.fb_namespace::has_added_app[0]);
				pageInfoData.founded = page.fb_namespace::founded;
				pageInfoData.company_overview = page.fb_namespace::company_overview;
				pageInfoData.mission = page.fb_namespace::mission;
				pageInfoData.products = page.fb_namespace::products;
				pageInfoData.release_date = page.fb_namespace::release_date;
				pageInfoData.starring = page.fb_namespace::starring;
				pageInfoData.written_by = page.fb_namespace::written_by;
				pageInfoData.directed_by = page.fb_namespace::directed_by;
				pageInfoData.produced_by = page.fb_namespace::produced_by;
				pageInfoData.studio = page.fb_namespace::studio;
				pageInfoData.awards = page.fb_namespace::awards;
				pageInfoData.plot_outline = page.fb_namespace::plot_outline;
				pageInfoData.network = page.fb_namespace::network;
				pageInfoData.season = page.fb_namespace::season;
				pageInfoData.schedule = page.fb_namespace::schedule;
				pageInfoCollection.addPageInfo(pageInfoData);
			}
			getPageInfoData.pageInfoCollection = pageInfoCollection;
			
			return getPageInfoData;
		}
		
		protected function parseFacebookPhoto(xml:XML):FacebookPhoto {
			
			var fbPhoto:FacebookPhoto = new FacebookPhoto();
			fbPhoto.pid = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::pid[0]);
			fbPhoto.aid = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::aid[0]);
			fbPhoto.owner = FacebookXMLParserUtils.toNumber(xml.fb_namespace::owner[0]);
			fbPhoto.src = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::src[0]);
			fbPhoto.src_big = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::src_big[0]);
			fbPhoto.src_small = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::src_small[0]);
			fbPhoto.link = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::link[0]);
			fbPhoto.caption = FacebookXMLParserUtils.toStringValue(xml.fb_namespace::caption[0]);
			return fbPhoto;
		}
		
		protected function parseGetAppUsersData(xml:XML):GetAppUserData {
			var uids:Array = FacebookXMLParserUtils.toUIDArray(xml);
			var appUserData:GetAppUserData = new GetAppUserData();
			appUserData.uids = uids;
			return appUserData;
		}
		
		protected function parseGetNotifications(xml:XML):GetNotificationData {
			var getNotificationData:GetNotificationData = new GetNotificationData();
			var notificationCollection:NotificationCollection = new NotificationCollection();
			
			for each(var message:* in xml.fb_namespace::messages) {
				var messageData:NotificationMessageData = new NotificationMessageData();
				messageData.unread = message.fb_namespace::unread;
				messageData.most_recent = message.fb_namespace::most_recent;
				notificationCollection.addItem(messageData);
			}
			
			for each(var poke:* in xml.fb_namespace::pokes) {
				var pokesData:NotificationPokeData = new NotificationPokeData();
				pokesData.unread = poke.fb_namespace::unread;
				pokesData.most_recent = poke.fb_namespace::most_recent;
				notificationCollection.addItem(pokesData);
			}
			
			for each(var share:* in xml.fb_namespace::shares) {
				var shareData:NotificationShareData = new NotificationShareData();
				shareData.unread = share.fb_namespace::unread;
				shareData.most_recent = share.fb_namespace::most_recent;
				notificationCollection.addItem(shareData);
			}
			
			getNotificationData.friendsRequests = FacebookXMLParserUtils.toUIDArray(xml.fb_namespace::friend_requests[0]);
			getNotificationData.group_invites = FacebookXMLParserUtils.toUIDArray(xml.fb_namespace::group_invites[0]);
			getNotificationData.event_invites = FacebookXMLParserUtils.toUIDArray(xml.fb_namespace::event_invites[0]);
			
			getNotificationData.notificationCollection = notificationCollection;
			
			return getNotificationData;
			
		}
		
		protected function parseGetGroupMembers(xml:XML):GetMemberData {
			var getMembersData:GetMemberData = new GetMemberData();
			
			getMembersData.members = FacebookXMLParserUtils.toUIDArray(xml.fb_namespace::members[0]);
			getMembersData.admins = FacebookXMLParserUtils.toUIDArray(xml.fb_namespace::admins[0]);
			getMembersData.officers = FacebookXMLParserUtils.toUIDArray(xml.fb_namespace::officers[0]);
			getMembersData.notReplied = FacebookXMLParserUtils.toUIDArray(xml.fb_namespace::not_replied[0]);
			
			return getMembersData;
		}
		
		protected function parseGetGroups(xml:XML):GetGroupData {
			var getGroupData:GetGroupData = new GetGroupData();
			var groupCollection:GroupCollection = new GroupCollection(); 
			
			for each(var group:* in xml..fb_namespace::group) {
				var groupDataVO:GroupData = new GroupData();
				groupDataVO.gid = group.fb_namespace::gid;
				groupDataVO.name = group.fb_namespace::name;
				groupDataVO.nid = group.fb_namespace::nid;
				groupDataVO.description = group.fb_namespace::description;
				groupDataVO.group_type = group.fb_namespace::group_type;
				groupDataVO.group_subtype = group.fb_namespace::group_subtype;
				groupDataVO.recent_news = group.fb_namespace::recent_news;
				groupDataVO.pic = group.fb_namespace::pic;
				groupDataVO.pic_big = group.fb_namespace::pic_big;
				groupDataVO.pic_small = group.fb_namespace::pic_small;
				groupDataVO.creator = group.fb_namespace::creator;
				groupDataVO.update_time = FacebookXMLParserUtils.toDate(group.fb_namespace::update_time);
				groupDataVO.office = group.fb_namespace::office;
				groupDataVO.website = group.fb_namespace::website; 
				groupDataVO.venue = FacebookXMLParserUtils.createLocation(group.fb_namespace::venue[0], fb_namespace);
				groupDataVO.privacy = group.fb_namespace::privacy;
				groupCollection.addGroup(groupDataVO);
			}
			getGroupData.groups = groupCollection;
			return getGroupData;
		}
		
		protected function parseGetFriends(xml:XML):GetFriendsData {
			var getFriendsData:GetFriendsData = new GetFriendsData();
			var myFriends:FacebookUserCollection = new FacebookUserCollection();
			
			for each(var friend:* in xml..fb_namespace::uid) {
				var fd:FacebookUser = new FacebookUser();
				fd.uid = friend;
				myFriends.addItem(fd);
			} 
			
			getFriendsData.friends = myFriends;
			return getFriendsData;
		}
		
		protected function parseAreFriends(xml:XML):AreFriendsData {
			var areFriendsData:AreFriendsData = new AreFriendsData();
			var friendsCollection:FriendsCollection = new FriendsCollection();
			for each(var friend:* in xml..fb_namespace::friend_info) {
				var friendData:FriendsData = new FriendsData();
				friendData.uid1 = friend.fb_namespace::uid1;
				friendData.uid2 = friend.fb_namespace::uid2;
				friendData.are_friends = FacebookXMLParserUtils.toBoolean(XML(friend.fb_namespace::are_friends.toXMLString())); //friendData.are_friends = FacebookXMLParserUtils.toBoolean(friend.fb_namespace::are_friends);
				friendsCollection.addItem(friendData);
			}
			areFriendsData.friendsCollection = friendsCollection;
			return areFriendsData;
		}
		
		protected function parseGetAppProperties(xml:XML):GetAppPropertiesData {
			var data:GetAppPropertiesData = new GetAppPropertiesData();
			data.appProperties = JSON.decode(xml.toString());
			return data;
		}
		
		protected function parseGetAllocation(result:XML):GetAllocationData {
			var data:GetAllocationData = new GetAllocationData();
			data.allocationLimit = Number(result.toString());
			return data;
		}
		
		protected function getAffiliation(xml:XML):AffiliationCollection {
			var arr:AffiliationCollection = new AffiliationCollection();
			
			for each(var aff:* in xml..fb_namespace::afflication) {
				var ad:AffiliationData = new AffiliationData();
				ad.nid = aff.fb_namespace::nid;
				ad.name = aff.fb_namespace::name;
				ad.type = aff.fb_namespace::type;
				ad.status = aff.fb_namespace::status;
				ad.year = aff.fb_namespace::year;
				arr.addAffiliation(ad);
			}
			return arr;
		}
		
		protected function parseBatchRun(xml:XML):FacebookData {
			var results:XMLList = xml..fb_namespace::batch_run_response_elt;
			var l:uint = results.length();
			var parsedResults:Array = [];
			
			for (var i:uint=0;i<l;i++) {
				var resultString:String = results[i].toString();
				var resultXML:XML = new XML(resultString);
				
				var error:FacebookError = validateFacebookResponce(resultString);
				if (error === null) {
					var methodName:String = responseNodeNameToMethodName(resultXML.localName().toString());
					var data:FacebookData = parse(resultString, methodName);
					
					parsedResults.push(data);
				} else {
					parsedResults.push(error);
				}
			}
			
			var br:BatchResult = new BatchResult();
			br.results = parsedResults;
			return br;
		}
		
		protected function responseNodeNameToMethodName(name:String):String {
			var peices:Array = name.split('_');
			peices.pop();
			return peices.join('.');
		}
		
		public function validateFacebookResponce(result:String):FacebookError {
			var error:FacebookError = null;
			var xml:XML;
			var xmlError:Error;
			
			var hasXMLError:Boolean = false;
			try {
				xml = new XML(result);
			} catch (e:*) {
				xmlError = e;
				hasXMLError = true
			}
			
			if (hasXMLError == false) {
				if (xml.localName() == 'error_response') {
					error = new FacebookError();
					error.rawResult = result;
					error.errorCode = Number(xml.fb_namespace::error_code);
					error.errorMsg = xml.fb_namespace::error_msg;
					error.requestArgs = FacebookXMLParserUtils.xmlToUrlVariables(xml..arg);
				}
				
				return error;
			}
			
			if (hasXMLError == true) {
				error = new FacebookError();
				error.error = xmlError;
				error.errorCode = -1;
			}
			
			return error;
		}
		
		public function createFacebookError(p_error:Object, p_result:String):FacebookError {
			var error:FacebookError = new FacebookError();
			error.rawResult = p_result;
			error.errorCode = FacebookErrorCodes.SERVER_ERROR;
			
			if (p_error is Error) {
				error.error = p_error as Error;
			} else {
				error.errorEvent = p_error as ErrorEvent;
			}
			return error;
		}
		
	}
}