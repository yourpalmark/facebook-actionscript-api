package com.pbking.facebook.data.users
{
	import com.pbking.facebook.data.misc.FacebookEducationInfo;
	import com.pbking.facebook.data.misc.FacebookLocation;
	import com.pbking.facebook.data.misc.FacebookNetwork;
	import com.pbking.facebook.data.misc.FacebookWorkInfo;
	import com.pbking.facebook.data.util.FacebookDataParser;
	import com.pbking.util.collection.HashableArray;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class FacebookUser extends EventDispatcher
	{
		public var uid:Number;
		
		public var isLoggedInUser:Boolean;
		
		public var name:String = "";
		public var first_name:String = "";
		public var last_name:String = "";
		
		public var pic:String;
		public var pic_big:String;
		public var pic_small:String;
		public var pic_square:String;

		public var sex:String;
		public var birthday:Date;
		public var about_me:String;
		public var activities:String;
		public var affiliations:Array;
		public var books:String;
		public var interests:String;
		public var movies:String;
		public var music:String;
		public var political:String;
		public var quotes:String;
		public var religion:String
		public var tv:String;

		public var networkAffiliations:Array;

		public var education_history:Array;

		public var timezone:int;
		public var current_location:FacebookLocation;
		public var hometown_location:FacebookLocation;

		public var hs1_name:String;
		public var hs2_name:String;
		public var grad_year:String;
		public var hs1_id:int;
		public var hs2_id:int;
		
		public var is_app_user:Boolean;
		public var has_added_app:Boolean;
		
		public var meeting_for:Array;
		public var meeting_sex:Array;
		
		public var relationship_status:String;
		public var significant_other_id:int;

		public var profile_update_time:Date;
		public var status_message:String;
		public var status_time:Date;

		public var notes_count:int;
		public var wall_count:int;
		
		public var work_history:Array;

		public var friends:Array;

 		function FacebookUser(uid:int):void
		{
			if(_locked)
				throw new Error("a user should be created by calling FacebookUser.getUser(uid) so that there is only ever a single instance of each user");
				
			this.uid = uid;
			
			//just making sure the UserFields is imported
			UserFields;
		}
		
		public function parseProperties(userProperties:Object):void
		{
			// NAME

			if(userProperties.name)
				this.name = userProperties.name.toString();

			if(userProperties.first_name)
				this.first_name = userProperties.first_name.toString();
				
			if(userProperties.last_name)
				this.last_name = userProperties.last_name.toString();
				
			// PICTURE
			
			if(userProperties.pic_small)
				this.pic_small = userProperties.pic_small.toString();

			if(userProperties.pic_big)
				this.pic_big = userProperties.pic_big.toString();

			if(userProperties.pic_square)
				this.pic_square = userProperties.pic_square.toString();

			if(userProperties.pic)
				this.pic = userProperties.pic.toString();

			// STATUS
			
			if(userProperties.status_message)
				this.status_message = userProperties.status.message.toString();

			if(userProperties.status_time)
				this.status_time = FacebookDataParser.formatDate(userProperties.status.time);
			
			// NETWORKS
			
			if(userProperties.pic)
			{
				this.affiliations = [];
				for each ( var xNetwork:Object in userProperties.affiliations ) 
				{
					var fbNetwork:FacebookNetwork = new FacebookNetwork();
					fbNetwork.nid = parseInt( xNetwork.nid );
					fbNetwork.name = xNetwork.name.toString();
					fbNetwork.type = xNetwork.type.toString();
					fbNetwork.status = xNetwork.status.toString();
					fbNetwork.year = xNetwork.year.toString();
	
					this.affiliations.push( fbNetwork );
				}
			}
			
			// HOMETOWN
			
			if(userProperties.hometown_location)
			{
				this.hometown_location = new FacebookLocation();
				this.hometown_location.city = userProperties.hometown_location.city.toString();
				this.hometown_location.state = userProperties.hometown_location.state.toString();
				this.hometown_location.country = userProperties.hometown_location.country.toString();
				this.hometown_location.zip = userProperties.hometown_location.zip.toString();
			}
			
			// MISC DETAILS
			
			if(userProperties.profile_update_time)
				this.profile_update_time = FacebookDataParser.formatDate( userProperties.profile_update_time.toString() );

			if(userProperties.timezone)
				this.timezone = parseInt( userProperties.timezone );

			if(userProperties.religion)
				this.religion = userProperties.religion.toString();

			if(userProperties.birthday)
				this.birthday = FacebookDataParser.formatDate(userProperties.birthday.toString());

			if(userProperties.sex)
				this.sex = userProperties.sex.toString();
			
			if(userProperties.political)
				this.political = userProperties.political.toString();

			if(userProperties.notes_count)
				this.notes_count = userProperties.notes_count.toString();

			if(userProperties.wall_count)
				this.wall_count = userProperties.wall_count.toString();

			// RELATIONSHIP
			
			if(userProperties.meeting_sex)
			{
				this.meeting_sex = [];
				for each ( var sex:XML in userProperties.meeting_sex.sex )
					this.meeting_sex.push( sex.toString() )
			}
			
			if(userProperties.meeting_sex)
			{
				this.meeting_for = [];
				for each ( var seeking:XML in userProperties.meeting_for.seeking )
					this.meeting_for.push( seeking.toString() )
			}
			
			if(userProperties.relationship_status)
				this.relationship_status = userProperties.relationship_status.toString();

			if(userProperties.significant_other_id)
				this.significant_other_id = parseInt( userProperties.significant_other_id );

			// LOCATION

			if(userProperties.hometown_location)
			{
				this.hometown_location = new FacebookLocation();
				this.hometown_location.city = userProperties.hometown_location.city;
				this.hometown_location.state = userProperties.hometown_location.state;
				this.hometown_location.country = userProperties.hometown_location.country;
				this.hometown_location.zip = userProperties.hometown_location.zip;
			}

			if(userProperties.current_location)
			{
				this.current_location = new FacebookLocation();
				this.current_location.city = userProperties.current_location.city;
				this.current_location.state = userProperties.current_location.state;
				this.current_location.country = userProperties.current_location.country;
				this.current_location.zip = userProperties.current_location.zip;
			}

			// INTERESTS AND SUCH

			if(userProperties.activities)
				this.activities = userProperties.activities.toString();

			if(userProperties.interests)
				this.interests = userProperties.interests.toString();

			if(userProperties.music)
				this.music = userProperties.music.toString();

			if(userProperties.tv)
				this.tv = userProperties.tv.toString();

			if(userProperties.movies)
				this.movies = userProperties.movies.toString();

			if(userProperties.books)
				this.books = userProperties.books.toString();

			if(userProperties.quotes)
				this.quotes = userProperties.quotes.toString();

			if(userProperties.about_me)
				this.about_me = userProperties.about_me.toString();
			
			// EDUCATION
			
			if(userProperties.hs1_name)
				this.hs1_name = userProperties.hs_info.hs1_name.toString();

			if(userProperties.hs2_name)
				this.hs2_name = userProperties.hs_info.hs2_name.toString();

			if(userProperties.grad_year)
				this.grad_year = userProperties.hs_info.grad_year.toString();

			if(userProperties.hs1_id)
				this.hs1_id = parseInt(userProperties.hs_info.hs1_id);

			if(userProperties.hs2_id)
				this.hs2_id = parseInt(userProperties.hs_info.hs2_id);
			
			if(userProperties.education_history)
			{
				this.education_history = [];
				for each ( var e:Object in userProperties.education_history ) 
				{
					var educationInfo:FacebookEducationInfo = new FacebookEducationInfo();
					educationInfo.name = e.name;
					educationInfo.year = e.year;
					educationInfo.concentrations = [];

					for each ( var c:XML in e.concentration )
						educationInfo.concentrations.push( c )
	
					this.education_history.push( educationInfo );
				}
			}
			
			// WORK

			if(userProperties.work_history)
			{
				this.work_history = [];
				
				for each ( var xWorkInfo:Object in userProperties.work_history ) 
				{
					var workInfo:FacebookWorkInfo = new FacebookWorkInfo();
	
					workInfo.location = new FacebookLocation();
					workInfo.location.city = xWorkInfo.location.city;
					workInfo.location.state = xWorkInfo.location.state;
					workInfo.location.country = xWorkInfo.location.country;
					workInfo.location.zip = xWorkInfo.location.zip;
	
					workInfo.company_name = xWorkInfo.company_name;
					workInfo.description = xWorkInfo.description;
					workInfo.position = xWorkInfo.position;
					workInfo.start_date = FacebookDataParser.formatDate(xWorkInfo.start_date);
					workInfo.end_date = FacebookDataParser.formatDate(xWorkInfo.end_date);
	
					this.work_history.push( workInfo );
				}
			}
			
			// APPLICATION
			
			if(userProperties.has_added_app)
				this.has_added_app = userProperties.has_added_app == 1;
				
			if(userProperties.is_app_user)
				this.is_app_user = userProperties.is_app_user == 1;
		}
		
		/**
		 * This keeps a common collection of users so that all information gathered
		 * on users is stored here and updated.  Each user should have only one instance.
		 * 
		 * Creating a user should happen from this method.
		 */
		public static function getUser(uid:int):FacebookUser
		{
			var user:FacebookUser = _userCollection.getItemById(uid) as FacebookUser;
			if(!user)
			{
				_locked = false;
				user = new FacebookUser(uid);
				_locked = true;
				_userCollection.addItem(user);
			}
			return user;
		}
		
		public static function getUsers(uids:Array):Array
		{
			var retUsers:Array = [];
			for (var i:int=0; i<uids.length; i++)
			{
				retUsers.push(getUser(uids[i]));
			}
			return retUsers;
		}
		
		private static var _userCollection:HashableArray = new HashableArray('uid', false);
		private static var _locked:Boolean = true;
	}
}