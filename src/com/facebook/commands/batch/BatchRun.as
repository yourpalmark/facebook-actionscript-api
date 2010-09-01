/**
 * http://wiki.developers.facebook.com/index.php/Data.setUserPreference
 * Feb 19/09
 */
/*
  Copyright (c) 2009, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package com.facebook.commands.batch {
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.data.InternalErrorMessages;
	import com.facebook.data.batch.BatchCollection;
	import com.facebook.delegates.RequestHelper;
	import com.facebook.net.FacebookCall;
	import com.facebook.facebook_internal;
	
	import flash.net.URLVariables;
	
	use namespace facebook_internal;
	
	/**
	 * The BatchRun class represents the public  
      Facebook API known as Batch.run.
	 * @see http://wiki.developers.facebook.com/index.php/Batch.run
	 */
	public class BatchRun extends FacebookCall {

		
		public static const METHOD_NAME:String = 'batch.run';
		public static const SCHEMA:Array = ['method_feed', 'serial_only'];
		
		public var method_feed:BatchCollection;
		public var serial_only:Boolean;
		
		use namespace facebook_internal;
		
		public function BatchRun(method_feed:BatchCollection, serial_only:Boolean = false) {
			super(METHOD_NAME);
			
			if (method_feed.length > 20) {
				throw new RangeError(InternalErrorMessages.BATCH_RUN_RANGE_ERROR);
			}
			
			this.method_feed = method_feed;
			this.serial_only = serial_only;
		}
		
		override facebook_internal function initialize():void {
			var actualFeed:Array = [];
			var l:uint = method_feed.length;
			
			for (var i:uint=0;i<l;i++) {
				var call:FacebookCall = method_feed.getItemAt(i) as FacebookCall;
				call.session = session;
				call.facebook_internal::initialize();
				
				RequestHelper.formatRequest(call);
				
				var urlVars:URLVariables = call.args;
				actualFeed.push(urlVars.toString());
			}
			
			var methodFeed:String = JSON.encode(actualFeed);
			applySchema(SCHEMA, methodFeed, serial_only);
			super.initialize();
			super.facebook_internal::initialize();
		}
	}
}