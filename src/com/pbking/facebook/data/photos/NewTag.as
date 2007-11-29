package com.pbking.facebook.data.photos
{
	[Bindable]
	public class NewTag
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var uid:int = 0;
		public var name:String = "";
		
		public function toString():String
		{
			var retString:String = "{";
			retString += '"x":"' + x + '"' + ',';
			retString += '"y":"' + y + '"' + ',';
			if(name != "")
				retString += '"tag_text":"' + name + '"';
			else
				retString += '"tag_uid":"' + uid + '"';
			retString += "}";		
			
			return retString;				
		}
	}
}