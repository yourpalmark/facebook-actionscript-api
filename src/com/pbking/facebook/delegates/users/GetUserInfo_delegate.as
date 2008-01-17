package com.pbking.facebook.delegates.users
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.misc.FacebookEducationInfo;
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.misc.FacebookNetwork;
	import com.pbking.facebook.data.misc.FacebookWorkInfo;
	import com.pbking.facebook.data.users.FacebookUser;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.facebook.delegates.FacebookDelegate;
	
	import flash.events.Event;

	public class GetUserInfo_delegate extends FacebookDelegate
	{
		public var users:Array;
		
		function GetUserInfo_delegate(users:Array, fields:Array)
		{
			this.users = users;
			var uids:Array = [];

			//put all of the users uids into an array to send
			for each(var user:FacebookUser in users)
				uids.push(user.uid);
				
			fbCall.setRequestArgument("uids", uids.join(","));
			fbCall.setRequestArgument("fields", fields.join(","));
			fbCall.post("facebook.users.getInfo");
			
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			default xml namespace = fBook.FACEBOOK_NAMESPACE;
			
			var xUserList:XMLList = resultXML..user;
			for each(var xUser:XML in xUserList)
			{
				var modUser:FacebookUser = fBook.getUser(parseInt(xUser.uid));
				//populate the fields in the xUser data

				// NAME

				if(xUser.name != undefined)
					modUser.name = xUser.name.toString();

				if(xUser.first_name != undefined)
					modUser.first_name = xUser.first_name.toString();
					
				if(xUser.last_name != undefined)
					modUser.last_name = xUser.last_name.toString();
					
				// PICTURE
				
				if(xUser.pic_small != undefined)
					modUser.pic_small = xUser.pic_small.toString();

				if(xUser.pic_big != undefined)
					modUser.pic_big = xUser.pic_big.toString();

				if(xUser.pic_square != undefined)
					modUser.pic_square = xUser.pic_square.toString();

				if(xUser.pic != undefined)
					modUser.pic = xUser.pic.toString();

				// STATUS
				
				if(xUser.status_message != undefined)
					modUser.status_message = xUser.status.message.toString();

				if(xUser.status_time != undefined)
					modUser.status_time = FacebookDataParser.formatDate(xUser.status.time);
				
				// NETWORKS
				
				if(xUser.pic != undefined)
				{
					modUser.affiliations = [];
					for each ( var xNetwork:XML in xUser.affiliations ) 
					{
						var fbNetwork:FacebookNetwork = new FacebookNetwork();
						fbNetwork.nid = parseInt( xNetwork.nid );
						fbNetwork.name = xNetwork.name.toString();
						fbNetwork.type = xNetwork.type.toString();
						fbNetwork.status = xNetwork.status.toString();
						fbNetwork.year = xNetwork.year.toString();
		
						modUser.affiliations.push( fbNetwork );
					}
				}
				
				// HOMETOWN
				
				if(xUser.hometown_location != undefined)
				{
					modUser.hometown_location = new FacebookLocation();
					modUser.hometown_location.city = xUser.hometown_location.city.toString();
					modUser.hometown_location.state = xUser.hometown_location.state.toString();
					modUser.hometown_location.country = xUser.hometown_location.country.toString();
					modUser.hometown_location.zip = xUser.hometown_location.zip.toString();
				}
				
				// MISC DETAILS
				
				if(xUser.profile_update_time != undefined)
					modUser.profile_update_time = FacebookDataParser.formatDate( xUser.profile_update_time.toString() );

				if(xUser.timezone != undefined)
					modUser.timezone = parseInt( xUser.timezone );

				if(xUser.religion != undefined)
					modUser.religion = xUser.religion.toString();

				if(xUser.birthday != undefined)
					modUser.birthday = FacebookDataParser.formatDate(xUser.birthday.toString());

				if(xUser.sex != undefined)
					modUser.sex = xUser.sex.toString();
				
				if(xUser.political != undefined)
					modUser.political = xUser.political.toString();

				if(xUser.notes_count != undefined)
					modUser.notes_count = xUser.notes_count.toString();

				if(xUser.wall_count != undefined)
					modUser.wall_count = xUser.wall_count.toString();

				// RELATIONSHIP
				
				if(xUser.meeting_sex != undefined)
				{
					modUser.meeting_sex = [];
					for each ( var sex:XML in xUser.meeting_sex.sex )
						modUser.meeting_sex.push( sex.toString() )
				}
				
				if(xUser.meeting_sex != undefined)
				{
					modUser.meeting_for = [];
					for each ( var seeking:XML in xUser.meeting_for.seeking )
						modUser.meeting_for.push( seeking.toString() )
				}
				
				if(xUser.relationship_status != undefined)
					modUser.relationship_status = xUser.relationship_status.toString();

				if(xUser.significant_other_id != undefined)
					modUser.significant_other_id = parseInt( xUser.significant_other_id );
	
				// LOCATION
	
				if(xUser.hometown_location != undefined)
				{
					modUser.hometown_location = new FacebookLocation();
					modUser.hometown_location.city = xUser.hometown_location.city.toString();
					modUser.hometown_location.state = xUser.hometown_location.state.toString();
					modUser.hometown_location.country = xUser.hometown_location.country.toString();
					modUser.hometown_location.zip = xUser.hometown_location.zip.toString();
				}
	
				if(xUser.current_location != undefined)
				{
					modUser.current_location = new FacebookLocation();
					modUser.current_location.city = xUser.current_location.city.toString();
					modUser.current_location.state = xUser.current_location.state.toString();
					modUser.current_location.country = xUser.current_location.country.toString();
					modUser.current_location.zip = xUser.current_location.zip.toString();
				}
	
				// INTERESTS AND SUCH
	
				if(xUser.activities != undefined)
					modUser.activities = xUser.activities.toString();

				if(xUser.interests != undefined)
					modUser.interests = xUser.interests.toString();

				if(xUser.music != undefined)
					modUser.music = xUser.music.toString();

				if(xUser.tv != undefined)
					modUser.tv = xUser.tv.toString();

				if(xUser.movies != undefined)
					modUser.movies = xUser.movies.toString();

				if(xUser.books != undefined)
					modUser.books = xUser.books.toString();

				if(xUser.quotes != undefined)
					modUser.quotes = xUser.quotes.toString();

				if(xUser.about_me != undefined)
					modUser.about_me = xUser.about_me.toString();
				
				// EDUCATION
				
				if(xUser.hs1_name != undefined)
					modUser.hs1_name = xUser.hs_info.hs1_name.toString();

				if(xUser.hs2_name != undefined)
					modUser.hs2_name = xUser.hs_info.hs2_name.toString();

				if(xUser.grad_year != undefined)
					modUser.grad_year = xUser.hs_info.grad_year.toString();

				if(xUser.hs1_id != undefined)
					modUser.hs1_id = parseInt(xUser.hs_info.hs1_id);

				if(xUser.hs2_id != undefined)
					modUser.hs2_id = parseInt(xUser.hs_info.hs2_id);
				
				if(xUser.education_history != undefined)
				{
					modUser.education_history = [];
					for each ( var e:XML in xUser.education_history ) 
					{
						var educationInfo:FacebookEducationInfo = new FacebookEducationInfo();
						educationInfo.name = e.name.toString();
						educationInfo.year = e.year.toString();
						educationInfo.concentrations = [];

						for each ( var c:XML in e.concentration )
							educationInfo.concentrations.push( c.toString() )
		
						modUser.education_history.push( educationInfo );
					}
				}
				
				// WORK
	
				if(xUser.work_history != undefined)
				{
					modUser.work_history = [];
					
					for each ( var xWorkInfo:XML in xUser.work_history ) 
					{
						var workInfo:FacebookWorkInfo = new FacebookWorkInfo();
		
						workInfo.location = new FacebookLocation();
						workInfo.location.city = xWorkInfo.location.city.toString();
						workInfo.location.state = xWorkInfo.location.state.toString();
						workInfo.location.country = xWorkInfo.location.country.toString();
						workInfo.location.zip = xWorkInfo.location.zip.toString();
		
						workInfo.company_name = xWorkInfo.company_name.toString();
						workInfo.description = xWorkInfo.description.toString();
						workInfo.position = xWorkInfo.position.toString();
						workInfo.start_date = FacebookDataParser.formatDate(xWorkInfo.start_date.toString());
						workInfo.end_date = FacebookDataParser.formatDate( xWorkInfo.end_date.toString() );
		
						modUser.work_history.push( workInfo );
					}
				}
				
				// APPLICATION
				
				if(xUser.has_added_app != undefined)
					modUser.has_added_app = xUser.has_added_app == 1;
					
				if(xUser.is_app_user != undefined)
					modUser.is_app_user = xUser.is_app_user == 1;
			}
			
		}
		
	}
}

/*		
<user>
      <uid>8055</uid>
      <about_me>This field perpetuates the glorification of the ego.  Also, it has a character limit.</about_me>
      <activities>Here: facebook, etc. There: Glee Club, a capella, teaching.</activities>
      <affiliations list="true">
        <affiliation>
          <nid>50453093</nid>
          <name>Facebook Developers</name>
          <type>work</type>
          <status/>
          <year/>
        </affiliation>
      </affiliations> 
      <birthday>November 3</birthday>
      <books>The Brothers K, GEB, Ken Wilber, Zen and the Art, Fitzgerald, The Emporer's New Mind, The Wonderful Story of Henry Sugar</books>
      <current_location>
        <city>Palo Alto</city>
        <state>CA</state>
        <country>United States</country>
        <zip>94303</zip>
      </current_location>
      <education_history list="true">
        <education_info>
          <name>Harvard</name>
          <year>2003</year>
          <concentrations list="true">
            <concentration>Applied Mathematics</concentration>
            <concentration>Computer Science</concentration>
          </concentrations>
        </education_info>
      </education_history>
      <first_name>Dave</first_name>
       <hometown_location>
         <city>York</city>
         <state>PA</state>
         <country>United States</country>
         <zip>0</zip>
       </hometown_location>
       <hs_info>
         <hs1_name>Central York High School</hs1_name>
         <hs2_name/>
         <grad_year>1999</grad_year>
         <hs1_id>21846</hs1_id>
         <hs2_id>0</hs2_id>
       </hs_info>
       <is_app_user>1</is_app_user>
       <has_added_app>1</has_added_app>
       <interests>coffee, computers, the funny, architecture, code breaking,snowboarding, philosophy, soccer, talking to strangers</interests>
       <last_name>Fetterman</last_name>
       <meeting_for list="true">
         <seeking>Friendship</seeking>
       </meeting_for>
       <meeting_sex list="true">
         <sex>female</sex>
       </meeting_sex>
       <movies>Tommy Boy, Billy Madison, Fight Club, Dirty Work, Meet the Parents, My Blue Heaven, Office Space </movies>
       <music>New Found Glory, Daft Punk, Weezer, The Crystal Method, Rage, the KLF, Green Day, Live, Coldplay, Panic at the Disco, Family Force 5</music>
       <name>Dave Fetterman</name>
       <notes_count>0</notes_count>
       <pic>http://photos-055.facebook.com/ip007/profile3/1271/65/s8055_39735.jpg</pic>
       <pic_big>http://photos-055.facebook.com/ip007/profile3/1271/65/n8055_39735.jpg</pic>
       <pic_small>http://photos-055.facebook.com/ip007/profile3/1271/65/t8055_39735.jpg</pic>
       <pic_square>http://photos-055.facebook.com/ip007/profile3/1271/65/q8055_39735.jpg</pic>
       <political>Moderate</political>
       <profile_update_time>1170414620</profile_update_time>
       <quotes/>
       <relationship_status>In a Relationship</relationship_status>
       <religion/>
       <sex>male</sex>
       <significant_other_id xsi:nil="true"/>
       <status>
         <message>Fast Company, November issue, page 84</message>
         <time>1193075616</time>
       </status>
       <timezone>-8</timezone>
       <tv>cf. Bob Trahan</tv>
       <wall_count>121</wall_count>
       <work_history list="true">
         <work_info>
           <location>
             <city>Palo Alto</city>
             <state>CA</state>
             <country>United States</country>
           </location>
           <company_name>Facebook</company_name>
           <position>Software Engineer</position>
           <description>Tech Lead, Facebook Platform</description>
           <start_date>2006-01</start_date>
           <end_date/>
          </work_info>
       </work_history>
    </user>
 */