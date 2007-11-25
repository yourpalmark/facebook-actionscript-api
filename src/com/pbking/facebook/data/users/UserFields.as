package com.pbking.facebook.data.users
{
	public class UserFields
	{
		public static const about_me:String = "about_me";
		public static const activities:String = "activities";
		public static const affiliations:String = "affiliations";
		public static const birthday:String = "birthday";
		public static const books:String = "books";
		public static const current_location:String = "current_location";
		public static const education_history:String = "education_history";
		public static const first_name:String = "first_name";
		public static const has_added_app:String = "has_added_app";
		public static const hometown_location:String = "hometown_location";
		public static const interests:String = "interests";
		public static const is_app_user:String = "is_app_user";
		public static const last_name:String = "last_name";
		public static const meeting_for:String = "meeting_for";
		public static const meeting_sex:String = "meeting_sex";
		public static const movies:String = "movies";
		public static const music:String = "music";
		public static const name:String = "name";
		public static const notes_count:String = "notes_count";
		public static const pic:String = "pic";
		public static const pic_big:String = "pic_big";
		public static const pic_small:String = "pic_small";
		public static const pic_square:String = "pic_square";
		public static const political:String = "political";
		public static const profile_update_time:String = "profile_update_time";
		public static const quotes:String = "quotes";
		public static const relationship_status:String = "relationship_status";
		public static const religion:String = "religion";
		public static const sex:String = "sex";
		public static const significant_other_id:String = "significant_other_id";
		public static const timezone:String = "timezone";
		public static const tv:String = "tv";
		public static const wall_count:String = "wall_count";
		public static const work_history:String = "work_history";
		public static const quotations:String = "quotes";
		
		public static const minimal_collection:Array = [name, pic];
		public static const entire_collection:Array = [ about_me, activities, affiliations, birthday, books, current_location, education_history, 
														first_name, has_added_app, hometown_location, interests, is_app_user, last_name, meeting_for, 
														meeting_sex, movies, music, name, notes_count, pic, pic_big, pic_small, pic_square, political, 
														profile_update_time, quotes, relationship_status, religion, sex, significant_other_id,
														timezone, tv, wall_count, work_history, quotations ];
	}
}
/*
    *  uid - The user id corresponding to the user info returned. This is always returned, whether included in fields or not, and always as the first subelement.
    * about_me - text element corresponding to Facebook \'About Me\' profile section. May be blank.
    * activities - User-entered "Activities" profile field. No guaranteed formatting.
    * affiliations - list of network affiliations, as affiliation elements, each of which contain year, type, status, name, and nid child elements. If no affiliations are returned, this element will be blank. The user's primary network (key: nid) will be listed first.
          o type takes the following values:
                + college: college network
                + high school: high school network
                + work: work network
                + region: geography network 
          o year may be blank, depending on the network type
          o name is the name of the network
          o nid is a unique identifier for the network. The user-to-network relation may be stored.
          o status describes the user's graduate status if the network is a college network. Otherwise, it is blank. 
    * birthday - User-entered "Birthday" profile field. No guaranteed formatting.
    * books - User-entered "Favorite Books" profile field. No guaranteed formatting.
    * current_location - User-entered "Current Location" profile fields. Contains four children: city, state, country, and zip.
          o city is user-entered, and may be blank
          o state is a well-defind two-letter American state or Canadian province abbreviation, and may be blank
          o country is well-defined, and may be blank.
          o zip is an integer, and is 0 if unspecified by the user. 
    * education_history - list of school information, as education_info elements, each of which contain name, year, and concentration child elements. If no school information is returned, this element will be blank.
          o year is a four-digit year, and may be blank
          o name is the name of the school, and is user-specified
          o concentrations is a list of concentration elements, and may be an empty list. 
    * first_name is generated from the user-entered "Name" profile field.
    * has_added_app - Bool (0 or 1) indicating whether the user has added the calling application to his facebook account.
    * hometown_location - User-entered "Hometown" profile fields. Contains four children: city, state, country, and zip.
          o city is user-entered, and may be blank
          o state is a well-defind two-letter American state or Canadian province abbreviation, and may be blank
          o country is well-defined, and may be blank.
          o zip is an integer, and is 0 if unspecified by the user. 
    * hs_info - User-entered high school information. Contains five children: hs1_name, hs2_name, grad_year, hs1_key, and hs2_key.
          o hs1_name is well-defined, and may be left blank
          o hs2_name is well-defined, and may be left blank, though may not have information if hs1_name is blank.
          o grad_year is a four-digit year, or may be blank
          o hs1_id is a unique id representing that school, and is not zero if and only if hs1_name is not blank.
          o hs2_id is a unique id representing that school, and is not zero if and only if hs2_name is not blank. 
    * interests - User-entered "Interests" profile field. No guaranteed formatting.
    * is_app_user - Bool (0 or 1) indicating whether the user has used the calling application.
    * last_name is generated from the user-entered "Name" profile field.
    * meeting_for - list of desired relationship types corresponding to the "Looking For" profile element. If no relationship typed are specified, the meeting_for element will be empty. Otherwise represented as a list of seeking child text elements, which may each contain one of the following strings: Friendship, A Relationship, Dating, Random Play, Whatever I can get .
    * meeting_sex - list of desired relationship genders corresponding to the "Interested In" profile element. If no relationship genders are specified, the meeting_sex element will be empty. Otherwise represented as a list of sex child text elements, which may each contain one of the following strings: male, female .
    * movies - User-entered "Favorite Movies" profile field. No guaranteed formatting.
    * music - User-entered "Favorite Music" profile field. No guaranteed formatting.
    * name - User-entered "Name" profile field. May not be blank.
    * notes_count - Total number of notes written by the user.
    * pic - URL of user profile picture, with max width 100px and max height 300px. May be blank.
    * pic_big - URL of user profile picture, with max width 200px and max height 600px. May be blank.
    * pic_small - URL of user profile picture, with max width 50px and max height 150px. May be blank.
    * pic_square - URL of a square section of the user profile picture, with width 50px and height 50px. May be blank.
    * political - User-entered "Political View" profile field. Is either blank or one of the following strings: Very Liberal, Liberal, Moderate, Conservative, Very Conservative, Apathetic, Libertarian, Other
    * profile_update_time - Time (in seconds since epoch) that the user's profile was last updated. If the user's profile was not updated recently, 0 will be returned.
    * quotes - User-entered "Favorite Quotes" profile field. No guaranteed formatting.
    * relationship_status - User-entered "Relationship Status" profile field. Is either blank or one of the following strings: Single, In a Relationship, In an Open Relationship, Engaged, Married, It's Complicated
    * religion - User-entered "Religious Views" profile field. No guaranteed formatting.
    * sex User-entered "Sex" profile file. Either "male", "female", or left blank.
    * significant_other_id - the id of the person the user is in a relationship with. Only shown if both people in the relationship are users of the application making the request.
    * status - Contains a "message" child with user-entered status information, as well as a "time" child with the time (in seconds since epoch) at which the status message was set.
    * timezone - offset from GMT (e.g. California is -8).
    * tv - User-entered "Favorite TV Shows" profile field. No guaranteed formatting.
    * wall_count - Total number of posts to the user's wall.
    * work_history - list of work history information, as work_info elements, each of which contain location, company_name, position, description, start_date and end_date child elements. If no work history information is returned, this element will be blank.
          o location is user-entered, and has a similar format to current_location and hometown_location above
          o company_name is user-entered, and does not necessarily correspond to a Facebook work network
          o description is user-entered, and may be blank
          o position is user-entered, and may be blank
          o start_date is of the form YYYY-MM, YYYY, or MM. It may be blank
          o end_date is of the form YYYY-MM, YYYY, or MM. It may be blank. 
*/