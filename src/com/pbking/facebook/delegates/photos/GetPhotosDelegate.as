/*
Copyright (c) 2007 Jason Crist

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

/**
 *  Delegates call to facebook.photo.get
 * 
 * @author Jason Crist 
 * @author Chris Hill
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