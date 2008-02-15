package com.pbking.facebook.delegates.fql
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class FqlQueryDelegate extends FacebookDelegate
	{
		public function FqlQueryDelegate(facebook:Facebook, query:String)
		{
			super(facebook);
			
			fbCall.setRequestArgument("query", query);
			fbCall.post("facebook.fql.query");
		}
		
	}
}