package com.pbking.util.collection
{
	import flash.utils.Dictionary;

	/**
	 * The HashableArrayCollection is an Array that has been extended
	 * to add all of the items in it to a hash map.  All items that are put into
	 * this array MUST have an .id property (else an error will be thrown).
	 * The id can be absolutely anything (string, number, function, complex object)  
	 * and will be used in the key to the hash.  Additional methods (such as
	 * getItemById) are added to facilitate a speedy retrieval without sorting
	 * or looping through the entire array.
	 * 
	 * @param allowDuplicateKey:Boolean  Allows items with like keys to be added.
	 * 									 True: When an item is added and its key 
	 * 								  	 already exists the item is added to the array
	 * 									 and it overwrites the place in the hash occupied
	 * 									 by the previous item.
	 * 									 False: When an item is added and its key
	 * 									 already exists the item is NOT added to the array
	 * 
	 * @param itemKeyProperty:String 	 The name of the property that will be used as the key.  Default is 'id'.
	 */
	public class HashableArray extends Array
	{
		// VARIABLES //////////
		
		private var hashedValues:Dictionary;
		private var allowDuplicateKey:Boolean;
		private var itemKeyProperty:String;
	
		// CONSTRUCTION //////////
	
		public function HashableArray(itemKeyProperty:String='id', allowDuplicateKey:Boolean=false)
		{
			this.itemKeyProperty = itemKeyProperty;
			this.allowDuplicateKey = allowDuplicateKey;
			hashedValues = new Dictionary(true);
		}

		// PUBLIC FUNCTIONS //////////

		public function addItem(item:Object):uint
		{
			if( addToHash(item) )
		    	super.push(item);
			
			return this.length;
		}
		
		public function contains(item:Object):Boolean
		{
			//check to see if it's already in the hash
			if(hashedValues[item[itemKeyProperty]])
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		public function removeAll():void
		{
			this.hashedValues = new Dictionary(true);
			this.splice(0);
		}
		
		public function getItemById(id:*):Object
		{
			return hashedValues[id];
		}
		
		public function removeItemById(id:*):Boolean
		{
			//check to see if we have it
			var item:Object = getItemById(id);
			
			if(!item)
				return false;
				
			return removeItem(item);
		}
		
		public function removeItem(item:Object):Boolean
		{
			if(contains(item))
			{
				delete this.hashedValues[item[itemKeyProperty]];
				this.splice(getItemIndex(item), 1);
				return true;
			}
			return false;
		}
		
		public function getItemIndex(item:Object):uint
		{
			if(contains(item))
			{
				return indexOf(item);
			}
			return null;
		}
		
		/*
		override public function push(...rest):uint
		{
			for(var i:uint = 0; i < rest.length; i++)
			{
				if( addToHash(rest[i]) )
			    	super.push(rest[i]);
			}
			return this.length;
		}
		
		override public function pop():*
		{
			var popedItem:* = super.pop();
			delete this.hashedValues[popedItem[itemKeyProperty]];
		}
		
		override public function shift():*
		{
			var popedItem:* = super.shift();
			delete this.hashedValues[popedItem[itemKeyProperty]];
		}
		
		override public function unshift(...rest):uint
		{
			for(var i:uint = 0; i < rest.length; i++)
			{
				if( addToHash(rest[i]) )
			    	super.unshift(rest[i]);
			}
			return this.length;
		}
		*/
		// PRIVATE UTILITIES //////////

		/**
		 * Checks to see if an item is hashable.  If it doesn't have an id, or if that ID is already in the hash it's not hashable
		 */
		private function checkHashItem(item:Object):Boolean
		{
			//check to see if the item has an ID property
			if(item[itemKeyProperty] == undefined || item[itemKeyProperty] == null)
			{
				throw new Error("An item added to a HashableArrayCollection must have an ID property");
				return false;
			}
			
			return true;
		}
		
		private function addToHash(item:Object):Boolean
		{
			if(checkHashItem(item))
			{
				if(hashedValues[item[itemKeyProperty]])
				{
					if(allowDuplicateKey)
					{
						trace("hashed value already exists!  Adding to array and replacing in hash: " + item[itemKeyProperty]);
						hashedValues[item[itemKeyProperty]] = item;
						return true;
					}
					else
					{
						trace("hashed value already exists!  Not adding to the array: " + item[itemKeyProperty]);
						return false;
					}
				}
				hashedValues[item[itemKeyProperty]] = item;
				return true;
			}
			return false;
		}
		
		private function removeFromHash(item:Object):void
		{
			delete hashedValues[item[itemKeyProperty]];
		}
	}
}