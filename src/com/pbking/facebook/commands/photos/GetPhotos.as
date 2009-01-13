/**
 *  Delegates call to facebook.photo.get
 * 
 * @author Jason Crist 
 */
package com.pbking.facebook.delegates.photos
{
	import com.pbking.facebook.FacebookCall;
	import com.pbking.facebook.data.*;
	import com.pbking.facebook.data.photos.FacebookPhoto;
	
	public class GetPhotos extends FacebookCall
	{
		// VARIABLES //////////
		
		public var subj_id:String;
		public var aid:String;
		public var pids:Array;
		
		public var photos:Array;
		
		// CONSTRUCTION //////////
		
		public function GetPhotos(subj_id:String=null, aid:String=null, pids:Array=null)
		{
			super("facebook.photos.get");
			
			this.subj_id = subj_id;
			this.aid = aid;
			this.pids = pids;
		}
		
		override public function initialize():void
		{
			if(subj_id==null && aid==null && pids==null)
				throw new Error('GetPhotos must have at least one of the values subj_id, aid, or pids set');
		
			clearRequestArguments();
			
			//strip out any 0's from our pids.  We can't get 0's.
			if(pids)
				while(pids.indexOf("0") != -1)
					pids.splice(pids.indexOf("0"), 1);

			if(subj_id) 
				setRequestArgument("subj_id", subj_id);
				 
			if(aid) 
				setRequestArgument("aid", aid);
				 
			if(pids) 
				setRequestArgument("pids", pids); 
		}
		
		override protected function handleSuccess(result:Object):void
		{
			photos = [];
			
			for each(var photo:Object in result)
			{
				photos.push(new FacebookPhoto(photo));
			} 
		}
		
		
	}
}