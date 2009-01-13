package com.pbking.facebook.delegates.fql
{
	import com.pbking.facebook.Facebook;

	public class FqlQueryDelegate extends FacebookDelegate
	{
		public var query:String;
		
		public function FqlQueryDelegate(query:String = null)
		{
			super("facebook.fql.query");
			
			this.query = query;
		}
		
		override public function inialize():void
		{			
			setRequestArgument("query", query);
		}
		
	}
}