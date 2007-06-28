

import com.facebook.objects.FBPhoto;
import com.facebook.lists.FBList;


/**
 * List to hold FBPhoto Objects
 */
class com.facebook.lists.FBPhotoList extends FBList {
	
	/**
	 * Load raw data tree into list
	 */
	static function build( tree:Object ):FBPhotoList {
		var List:FBPhotoList = new FBPhotoList();
		for( var s:String in tree ){
			var Obj:FBPhoto = new FBPhoto();
			Obj.setProperties( tree[s] );
			List.unshift( Obj );
		}
		return List;
	}
	
	
}