package com.pbking.util.collection
{
	import mx.collections.ArrayCollection;
	import flash.utils.Dictionary;

	/**
	 * The HashableArrayCollection is an ArrayCollection that has been extended
	 * to add all of the items to it to a hash map.  All items that are put into
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
	public class HashableArrayCollection extends ArrayCollection
	{
		// VARIABLES //////////
		
		private var hashedValues:Dictionary;
		private var allowDuplicateKey:Boolean;
		private var itemKeyProperty:String;
	
		// CONSTRUCTION //////////
	
		public function HashableArrayCollection(itemKeyProperty:String='id', allowDuplicateKey:Boolean=true)
		{
			this.itemKeyProperty = itemKeyProperty;
			this.allowDuplicateKey = allowDuplicateKey;
			hashedValues = new Dictionary(true);
		}

		// PUBLIC FUNCTIONS //////////
		
		override public function setItemAt(item:Object, index:int):Object
	    {
			if(addToHash(item))
			{
				return super.setItemAt(item, index);
			}
			else
			{
				return null;
			}
	    }

		override public function addItemAt(item:Object, index:int):void
	    {
	    	if(addToHash(item))
		    	super.addItemAt(item, index);
	    }

		override public function removeItemAt(index:int):Object
		{
			var item:Object = super.removeItemAt(index);
			
			if(item)
				removeFromHash(item);
				
			return item;
		}

		override public function removeAll():void
		{
			this.hashedValues = new Dictionary(true);
			super.removeAll();
		}
		
		public function getItemById(id:*):Object
		{
			return hashedValues[id];
		}
		
		public function removeItem(item:Object):Boolean
		{
			if(contains(item))
			{
				removeItemAt(getItemIndex(item));
				return true;
			}
			return false;
		}
		
		override public function contains(item:Object):Boolean
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