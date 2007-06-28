

import com.facebook.objects.FBAlbum;
import com.facebook.lists.FBList;


/**
 * List to hold FBAlbum Objects
 */
class com.facebook.lists.FBAlbumList extends FBList {
	
	/**
	 * Load raw data tree into list
	 */
	static function build( tree:Object ):FBAlbumList {
		var List:FBAlbumList = new FBAlbumList();
		for( var s:String in tree ){
			var Obj:FBAlbum = new FBAlbum();
			Obj.setProperties( tree[s] );
			List.unshift( Obj );
		}
		return List;
	}
	
	
}