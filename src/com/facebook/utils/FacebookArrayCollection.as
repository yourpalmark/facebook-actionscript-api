/*
  Copyright (c) 2009, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package com.facebook.utils {

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	[Bindable]
	public class FacebookArrayCollection extends EventDispatcher {
		
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
	    
	    override public function toString():String {
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
