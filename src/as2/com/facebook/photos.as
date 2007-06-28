

import com.facebook.FacebookXML;
import com.facebook.lists.FBAlbumList;
import com.facebook.lists.FBPhotoList;
import com.facebook.objects.FBPhoto;



/**
 * 
 */
class com.facebook.photos extends Object {
	
	
	/**
	 * Short cut method to "facebook.photos.get"
	 * @see http://developers.facebook.com/documentation.php?v=1.0&method=photos.get
	 * @param String 
	 * @param String Album ID
	 * @param Array list of individual photo IDs
	 */
	static function get( subj_id:String, aid:String, pids:Array ):FacebookXML {
		var X:FacebookXML = new FacebookXML( FBPhotoList );
		if( subj_id ){
			X.setRequestArgument( 'subj_id', subj_id );
		}
		if( aid ){
			X.setRequestArgument( 'aid', aid );
		}
		if( pids instanceof Array && pids.length ){
			X.setRequestArgument( 'pids', pids.join(',') );
		}
		X.post( 'facebook.photos.get' );
		return X;
	}
	
	
	
	/**
	 * Short cut method to "facebook.photos.getAlbums"
	 * @see http://developers.facebook.com/documentation.php?v=1.0&method=photos.getAlbums
	 * @param String User ID of Album owner
	 * @param Array list of individual photo IDs
	 */
	static function getAlbums( uid:String, pids:Array ):FacebookXML {
		var X:FacebookXML = new FacebookXML( FBAlbumList );
		if( !uid ){
			uid = com.facebook.Facebook.UID;
		}
		X.setRequestArgument( 'uid', uid );
		if( pids instanceof Array && pids.length ){
			X.setRequestArgument( 'pids', pids.join(',') );
		}
		X.post( 'facebook.photos.getAlbums' );
		return X;
	}
	
	
	
}