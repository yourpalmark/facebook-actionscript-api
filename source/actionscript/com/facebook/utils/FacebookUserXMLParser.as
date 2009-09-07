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
	
	import com.facebook.data.FacebookEducationInfo;
	import com.facebook.data.FacebookNetwork;
	import com.facebook.data.FacebookWorkInfo;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.data.users.StatusData;
	
	public class FacebookUserXMLParser {
		
		public static function createFacebookUser(userProperties:XML, ns:Namespace):FacebookUser {
			var fbUser:FacebookUser = new FacebookUser();
			
			var props:XMLList = userProperties.children();
			var l:uint = props.length();
			var userNode:XML;
			var localName:String;
			
			for (var i:uint=0; i<l; i++) {
				userNode = props[i];
				localName = userNode.localName().toString();
				switch (localName) {
					//Custom Parsing
					case 'status':
						fbUser[localName] = createStatus(userNode, ns); break;
					case 'affiliations':
						fbUser[localName] = createAffiliations(userNode.children(), ns); break;
					case 'hometown_location':
					case 'current_location':
						fbUser[localName] = FacebookXMLParserUtils.createLocation(userNode, ns); break;
					case 'profile_update_time':
						fbUser[localName] = FacebookDataUtils.formatDate(userNode.toString()); break;
					case 'hs_info':
						fbUser.hs1_id = parseInt(userNode.ns::hs1_id);
						fbUser.hs1_name = String(userNode.ns::hs1_name);
						fbUser.hs2_id = parseInt(userNode.ns::hs2_id)
						fbUser.hs2_name = String(userNode.ns::hs2_name);
						fbUser.grad_year = String(userNode.ns::grad_year);						
						break;
					case 'education_history':
						fbUser[localName] = parseEducationHistory(userNode, ns); break;
					case 'work_history':
						fbUser[localName] = parseWorkHistory(userNode, ns); break;
						
					//Number parsing
					case 'timezone':
					case 'notes_count':
					case 'wall_count':
						fbUser[localName] = Number(userNode.toString()); break;
						
					//Boolean parsing
					case 'has_added_app':
					case 'is_app_user':
						fbUser[localName] = FacebookXMLParserUtils.toBoolean(userNode); break;
					
					//Flat Array parsing
					case 'meeting_sex':
					case 'meeting_for':
					case 'email_hashes':
						fbUser[localName] = toArray(userNode, ns); break;
					
					//Default everthing else to a String
					default:
						if (localName in fbUser) { //Check to make sure this isn't a new or un-supported property.
							fbUser[localName] = String(userNode);
						}
				}
			}
			
			return fbUser;
		}
		
		protected static function parseWorkHistory(xml:XML, ns:Namespace):Array {
			var work_history:Array = [];
			var xList:XMLList = xml.children();
			
			for each (var xWorkInfo:Object in xList) {
				var workInfo:FacebookWorkInfo = new FacebookWorkInfo();
				
				workInfo.location = FacebookXMLParserUtils.createLocation(xWorkInfo.ns::location[0], ns);
				
				workInfo.company_name = String(xWorkInfo.ns::company_name);
				
				workInfo.description = String(xWorkInfo.ns::description);
				workInfo.position = String(xWorkInfo.ns::position);
				workInfo.start_date = FacebookDataUtils.formatDate(xWorkInfo.ns::start_date);
				workInfo.end_date = FacebookDataUtils.formatDate(xWorkInfo.ns::end_date);
				work_history.push(workInfo);
			}
			
			return work_history;
		}
		
		protected static function parseEducationHistory(xml:XML, ns:Namespace):Array {
			var education_history:Array = [];
			var xList:XMLList = xml.children();
			
			for each (var e:Object in xList) {
				var educationInfo:FacebookEducationInfo = new FacebookEducationInfo();
				educationInfo.name = String(e.ns::name);
				educationInfo.year = String(e.ns::year);
				educationInfo.degree = String(e.ns::degree);
				educationInfo.concentrations = [];
				for each (var c:XML in e.concentration) {
					educationInfo.concentrations.push(c);
				}
				education_history.push(educationInfo);
			}
			
			return education_history;
		}
		
		protected static function toArray(xml:XML, ns:Namespace):Array {
			var arr:Array = [];
			var children:XMLList = xml.children();
			var l:uint = children.length();
			for (var i:uint=0;i<l;i++) {
				arr.push(children[i].toString());
			}
			
			return arr;
		}
		
		
		protected static function createAffiliations(affilications:XMLList, ns:Namespace):Array {
			var arr:Array = [];
			for each (var xNetwork:* in affilications) {
				var fbNetwork:FacebookNetwork = new FacebookNetwork();
				fbNetwork.nid = parseInt( xNetwork.ns::nid );
				fbNetwork.name = String(xNetwork.ns::name);
				fbNetwork.type = String(xNetwork.ns::type);
				fbNetwork.status = String(xNetwork.ns::status);
				fbNetwork.year = String(xNetwork.ns::year);
				arr.push(fbNetwork);
			}
			return arr;
		}
		
		protected static function createStatus(status:XML, ns:Namespace):StatusData {
			var statusData:StatusData = new StatusData();
			statusData.message = String(status.ns::message);
			statusData.time = FacebookDataUtils.formatDate(String(status.ns::time));
			return statusData;
		}

	}
}