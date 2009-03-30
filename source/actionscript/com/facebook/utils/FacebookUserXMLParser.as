package com.facebook.utils {
	
	import com.facebook.data.FacebookEducationInfo;
	import com.facebook.data.FacebookLocation;
	import com.facebook.data.FacebookNetwork;
	import com.facebook.data.FacebookWorkInfo;
	import com.facebook.data.users.FacebookUser;
	
	
	public class FacebookUserXMLParser {
		
		public function FacebookUserXMLParser() { }
		
		public static function createFacebookUser(userProperties:XML, ns:Namespace):FacebookUser {
			//var userID:Number = Number(userProperties..uid[0]);
			var hometownLocation:XMLList;
			var currentLocation:XMLList;
			var fbUser:FacebookUser = new FacebookUser();
			fbUser.uid = userProperties..ns::uid;
			
			if (fbUser != null) {
				//return fbUser;
			}
			
			if (userProperties.name) { 
				fbUser.name = userProperties..ns::name.toString(); 
			}
			
			if (userProperties..ns::first_name) { 
				fbUser.first_name = userProperties..ns::first_name.toString();
			}
			
			if (userProperties..ns::last_name) { 
				fbUser.last_name = userProperties..ns::last_name.toString(); 
			}
				
			// PICTURE
			if (userProperties..ns::pic_small) {
				fbUser.pic_small = userProperties..ns::pic_small.toString();
			}

			if (userProperties..ns::pic_big) {
				fbUser.pic_big = userProperties..ns::pic_big.toString();
			}

			if (userProperties..ns::pic_square) {
				fbUser.pic_square = userProperties..ns::pic_square.toString();
			}

			if (userProperties..ns::pic) {
				fbUser.pic = userProperties.pic.toString();
			}

			// STATUS
			if (userProperties..ns::status_message) {
				fbUser.status_message = userProperties..ns::status.message.toString();
			}

			if (userProperties..ns::status_time) {
				fbUser.status_time = FacebookDataUtils.formatDate(userProperties..ns::status.time);
			}
			
			// NETWORKS
			if (userProperties..ns::affiliations) {
				fbUser.affiliations = [];
				for each (var xNetwork:Object in userProperties..ns::affiliations) {
					var fbNetwork:FacebookNetwork = new FacebookNetwork();
					fbNetwork.nid = parseInt( xNetwork.nid );
					fbNetwork.name = xNetwork.name.toString();
					fbNetwork.type = xNetwork.type.toString();
					fbNetwork.status = xNetwork.status.toString();
					fbNetwork.year = xNetwork.year.toString();
	
					fbUser.affiliations.push(fbNetwork);
				}
			}
			
			// HOMETOWN
			if (userProperties..ns::hometown_location) {
				fbUser.hometown_location = new FacebookLocation();
				fbUser.hometown_location.city = userProperties..ns::hometown_location.city.toString();
				fbUser.hometown_location.state = userProperties..ns::hometown_location.state.toString();
				fbUser.hometown_location.country = userProperties..ns::hometown_location.country.toString();
				fbUser.hometown_location.zip = userProperties..ns::hometown_location.zip.toString();
			}
			
			// MISC DETAILS
			if (userProperties..ns::profile_update_time) {
				fbUser.profile_update_time = FacebookDataUtils.formatDate( userProperties..ns::profile_update_time.toString() );
			}

			if (userProperties..ns::timezone) {
				fbUser.timezone = parseInt( userProperties..ns::timezone );
			}

			if (userProperties..ns::religion) {
				fbUser.religion = userProperties..ns::religion.toString();
			}

			if (userProperties..ns::birthday) {
				fbUser.birthday = userProperties..ns::birthday.toString();
			}

			if (userProperties..ns::sex) {
				fbUser.sex = userProperties.sex.toString();
			}
			
			if (userProperties..ns::political) {
				fbUser.political = userProperties..ns::political.toString();
			}

			if (userProperties..ns::notes_count) {
				fbUser.notes_count = userProperties..ns::notes_count.toString();
			}

			if (userProperties..ns::wall_count) {
				fbUser.wall_count = userProperties..ns::wall_count.toString();
			}

			// RELATIONSHIP
			if (userProperties..ns::meeting_sex) {
				fbUser.meeting_sex = [];
				for each (var sex:XML in userProperties..ns::meeting_sex.sex) {
					fbUser.meeting_sex.push(sex.toString());
				}
			}
			
			if (userProperties..ns::meeting_for) {
				fbUser.meeting_for = [];
				for each (var seeking:XML in userProperties..ns::meeting_for.seeking) {
					fbUser.meeting_for.push(seeking.toString())
				}
			}
			
			if (userProperties..ns::relationship_status) {
				fbUser.relationship_status = userProperties.relationship_status.toString();
			}

			if (userProperties..ns::significant_other_id) {
				fbUser.significant_other_id = parseInt(userProperties..ns::significant_other_id);
			}

			// LOCATION
			if (userProperties..ns::hometown_location) {
				fbUser.hometown_location = new FacebookLocation();
				hometownLocation = userProperties..ns::hometown_location
				fbUser.hometown_location.city = hometownLocation..ns::city;
				fbUser.hometown_location.state = hometownLocation..ns::state;
				fbUser.hometown_location.country = hometownLocation..ns::country;
				fbUser.hometown_location.zip = hometownLocation..ns::zip;
			}

			if (userProperties..ns::current_location) {
				fbUser.current_location = new FacebookLocation();
				currentLocation = userProperties..ns::current_location;
				fbUser.current_location.city = currentLocation..ns::city;
				fbUser.current_location.state = currentLocation..ns::state;
				fbUser.current_location.country = currentLocation..ns::country;
				fbUser.current_location.zip = currentLocation..ns::zip;
			}

			// INTERESTS AND SUCH
			if (userProperties..ns::activities) {
				fbUser.activities = userProperties..ns::activities.toString();
			}

			if (userProperties..ns::interests) {
				fbUser.interests = userProperties..ns::interests.toString();
			}

			if (userProperties..ns::music) {
				fbUser.music = userProperties..ns::music.toString();
			}

			if (userProperties..ns::tv) {
				fbUser.tv = userProperties..ns::tv.toString();
			}

			if (userProperties..ns::movies) {
				fbUser.movies = userProperties..ns::movies.toString();
			}

			if (userProperties..ns::books) {
				fbUser.books = userProperties..ns::books.toString();
			}

			if (userProperties..ns::quotes) {
				fbUser.quotes = userProperties..ns::quotes.toString();
			}

			if (userProperties..ns::about_me) {
				fbUser.about_me = userProperties..ns::about_me.toString();
			}
			
			// EDUCATION
			if (userProperties..ns::hs1_name) {
				fbUser.hs1_name = userProperties..ns::hs_info.hs1_name.toString();
			}

			if (userProperties..ns::hs2_name) {
				fbUser.hs2_name = userProperties..ns::hs_info.hs2_name.toString();
			}

			if (userProperties..ns::grad_year) {
				fbUser.grad_year = userProperties..ns::hs_info.grad_year.toString();
			}

			if (userProperties..ns::hs1_id) {
				fbUser.hs1_id = parseInt(userProperties..ns::hs_info.hs1_id);
			}

			if (userProperties..ns::hs2_id) {
				fbUser.hs2_id = parseInt(userProperties..ns::hs_info.hs2_id);
			}
			
			if (userProperties..ns::education_history) {
				fbUser.education_history = [];
				for each (var e:Object in userProperties..ns::education_history) {
					var educationInfo:FacebookEducationInfo = new FacebookEducationInfo();
					educationInfo.name = e.name;
					educationInfo.year = e.year;
					educationInfo.concentrations = [];

					for each (var c:XML in e.concentration) {
						educationInfo.concentrations.push(c);
					}
	
					fbUser.education_history.push(educationInfo);
				}
			}
			
			// WORK
			if (userProperties..ns::work_history) {
				fbUser.work_history = [];
				
				for each (var xWorkInfo:Object in userProperties..ns::work_history) {
					var workInfo:FacebookWorkInfo = new FacebookWorkInfo();
	
					workInfo.location = new FacebookLocation();
					
					workInfo.location.city = xWorkInfo.location.city;
					workInfo.location.state = xWorkInfo.location.state;
					workInfo.location.country = xWorkInfo.location.country;
					workInfo.location.zip = xWorkInfo.location.zip;
	
					workInfo.company_name = xWorkInfo.company_name;
					workInfo.description = xWorkInfo.description;
					workInfo.position = xWorkInfo.position;
					workInfo.start_date = FacebookDataUtils.formatDate(xWorkInfo.start_date);
					workInfo.end_date = FacebookDataUtils.formatDate(xWorkInfo.end_date);
					
					fbUser.work_history.push( workInfo );
				}
			}
			
			// APPLICATION
			if (userProperties..ns::has_added_app) {
				fbUser.has_added_app = userProperties..ns::has_added_app == 1;
			}
				
			if (userProperties..ns::is_app_user) {
				fbUser.is_app_user = userProperties..ns::is_app_user == 1;
			}
			
			return fbUser;
		}

	}
}