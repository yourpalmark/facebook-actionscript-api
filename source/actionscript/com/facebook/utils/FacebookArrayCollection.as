package com.facebook.utils {

	import flash.utils.Dictionary;
	
	public class FacebookArrayCollection {
		
		protected var _source:Array;
		protected var hash:Dictionary;
		
		protected var _type:Class;
		
		/**
		 * Utility class to organize a collection of Objects
		 * 
		 * @param source Default source for this collection.
		 * @param type Type of all objects that need to be added to this collection. Treats this collection as an Vector,
		 * 
		 */
	    public function FacebookArrayCollection(source:Array = null, type:Class = null) {
	        super();
	        
	        reset();
	        _type = type;
	        
	        initilizeSource(source);
	    }
	    
	    public function get type():Class { return _type; }
	    public function get length():int { return _source.length; }
	    public function get source():Array { return _source; }
	    
	    public function toArray():Array {
	    	var newArr:Array = [];
	    	
	    	var l:uint = length;
	    	for (var i:uint=0;i<l;i++) {
	    		newArr.push(getItemAt(i));
	    	}
	    	
	    	return newArr;
	    }
	    
	    public function addItem(item:Object):void {
	    	addItemAt(item, length);
	    }
	    
	    public function addItemAt(item:Object, index:uint):void {
	    	if (hash[item] != null) {
	    		throw new Error('Item already exists.');
	    	}
	    	
	    	if (_type !== null && !(item is _type)) {
	    		throw new TypeError('This collection requires ' + _type + ' as the type.');
	    	}
	    	
	    	hash[item] = true;
	    	_source.splice(index, 0, item);
	    }
	    
	    public function findItemByProperty(prop:String, value:Object, strict:Boolean = false):Object {
	    	for (var obj:Object in hash) {
	    		if (strict && prop in obj && obj[prop] === value) {
	    			return obj;
	    		} else if (!strict && prop in obj && obj[prop] == value) {
	    			return obj;
	    		}
	    	}
	    	
	    	return null;
	    }
	    
	    public function getItemAt(index:uint):Object {
	    	verifyIndex(index);
	    	return _source[index];
	    }
	    
	    public function removeItemAt(index:uint):void {
	    	verifyIndex(index);
	    	var item:Object = _source[index];
	    	
	    	delete hash[item];
	    	_source.splice(index, 1);
	    }
	    
	    public function indexOf(item:Object):int {
	    	return _source.indexOf(item);
	    }
	    
	    public function contains(value:Object):Boolean {
	    	return hash[value] === true;
	    }
	    
	    public function reset():void {
	    	hash = new Dictionary(true);
	    	_source = [];
	    }
	    
	    public function toString():String {
	    	return _source.join(', ');
	    }
	    
	    protected function initilizeSource(source:Array):void {
	    	_source = [];
	    	
	    	if (source == null) { return; }
	    	
	    	var l:uint = source.length;
	    	for (var i:uint=0;i<l;i++) {
	    		addItem(source[i]);
	    	}
	    }
	    
	    protected function verifyIndex(index:uint):void {
	    	if (_source.length < index) {
	    		throw new RangeError('Index: ' + index + ', is out of range.');
	    	}
	    }
	    
	}
}
