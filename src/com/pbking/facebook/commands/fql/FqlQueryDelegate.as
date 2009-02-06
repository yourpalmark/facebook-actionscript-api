package com.pbking.facebook.commands.fql
{
	import com.pbking.facebook.FacebookCall;

	[Bindable]
	public class FqlQueryDelegate extends FacebookCall
	{
		public var query:String;
		
		public function FqlQueryDelegate(query:String = null)
		{
			super("facebook.fql.query");
			
			this.query = query;
		}
		
		override public function initialize():void
		{			
			setRequestArgument("query", query);
		}
		
	}
}