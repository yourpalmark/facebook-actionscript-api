

import com.facebook.objects.FBObject;


/**
 * Base class for all list arrays
 */
class com.facebook.lists.FBList extends Array {
	
	
	/**
	 * Load raw data tree into list
	 * @abstract
	 */
	static function build( tree:Object ):Void {
		throw 'All FBList subclasses must implement a build method';
	}
	
}