/**
 *  Delegates call to facebook.photo.get
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.*;
	import com.pbking.facebook.data.photos.FacebookPhoto;
	import com.pbking.facebook.delegates.FacebookDelegate;
	import com.pbking.util.logging.PBLogger;
	
	public class GetPhotosDelegate extends FacebookDelegate
	{
		// VARIABLES //////////
		
		public var photos:Array;
		
		// CONSTRUCTION //////////
		
		public function GetPhotosDelegate(facebook:Facebook, subj_id:Object=null, aid:Object=null, pids:Array=null)
		{
			super(facebook);
			
			if(subj_id==null && aid==null && pids==null)
				throw new Error('GetPhotos must have at least one of the values subj_id, aid, or pids set');
			
			PBLogger.getLogger("pbking.facebook").debug("getting photos based on query: subj_id: " + subj_id + " aid: " + aid + " pids: " + pids);

			//strip out any 0's from our pids.  We can't get 0's.
			if(pids)
				while(pids.indexOf("0") != -1)
					pids.splice(pids.indexOf("0"), 1);

			if(subj_id){ fbCall.setRequestArgument("subj_id", subj_id.toString()); }
			if(aid){ fbCall.setRequestArgument("aid", aid.toString()); }
			if(pids){ fbCall.setRequestArgument("pids", pids.toString()); }
			
			fbCall.post("facebook.photos.get");
		}
		
		override protected function handleResult(result:Object):void
		{
			photos = [];
			
			for each(var photo:Object in result)
			{
				photos.push(new FacebookPhoto(photo));
			} 
		}
		
		
	}
}