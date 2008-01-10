package com.pbking.facebook.delegates.fql
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.delegates.FacebookDelegate;

	public class FqlQuery_delegate extends FacebookDelegate
	{
		public var queryResult:XML;
		
		public function FqlQuery_delegate(query:String)
		{
			fbCall.setRequestArgument("query", query);
			fbCall.post("facebook.fql.query");
		}
		
		override protected function handleResult(resultXML:XML):void
		{
			super.handleResult(resultXML);
			
			default xml namespace = fBook.FACEBOOK_NAMESPACE;

			this.queryResult = resultXML;
		}
		
	}
}