





/**
 * Base class for all simple data objects
 */
class com.facebook.objects.FBObject extends Object {
	

	
	/**
	 * Load raw data structure into object
	 * @abstract
	 */
	static function build( data:Object ):Void {
		throw 'All FBObject subclasses must implement a build method';
	}
	
	
	
	/** 
	 * Set multiple properties
	 */
	function setProperties( data:Object ):Void {
		for( var s:String in data ){
			this.setProperty( s, data[s] );
		}		
	}
	
	
	
	/**
	 * Test whether original object should have property defined. even if null
	 * ensure to declare a non-undefined value in class definition
	 */
	function hasProperty( name:String ):Boolean {
		return this[name] !== undefined || this.__proto__[name] !== undefined;
	}
	
	
	
	/**
	 * Set a raw string property.
	 * This is specifically designed for setting properties returned in Facebook XML response
	 */
	function setProperty( name:String, value:String ):Object {
		// object must be constructed with typed variables for this to work
		if( !this.hasProperty(name) ){
			return null;
		}
		if( value == null ){
			return this[name] = null; // <- lost type for next time, see hack below
		}
		// get type of current variable
		var t:String = typeof this[name];
		if( t == "null" || t == "undefined" ){
			t = typeof this.__proto__[name];
		}
		// cast new value to type of current value
		switch( t ){
		case 'number':
			this[name] = Number( value );
			break;
		case 'string':
			this[name] = String( value );
			break;
		default:
		//  parse date integers
			if( this[name] instanceof Date ){
				// assume unix timestamp from facebook server
				var u:Number = Number( value ) * 1000;
				if( typeof u != 'number' || isNaN(u) ){
					_global.trace( "Bad datetime value ("+typeof value+")" + value );
				}
				this[name] = new Date( u );
			}
		//  default to value as-is
			else {
				this[name] = value;
			}
		}
		// return new [current] value
		return this[name];		
	}
	
	
	
	
}