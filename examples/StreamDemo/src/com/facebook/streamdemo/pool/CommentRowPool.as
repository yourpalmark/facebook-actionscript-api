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
package com.facebook.streamdemo.pool {
	
	import com.facebook.data.stream.PostCommentData;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.streamdemo.controls.CommentRow;
	import com.facebook.utils.DesktopSessionHelper;
	
	public class CommentRowPool {
		
		protected static var _instance:CommentRowPool;
		protected static var _canInit:Boolean = false;
		protected static var _desktopHelper:DesktopSessionHelper;
		
		protected var avilableRows:Array;
		
		public function CommentRowPool() {
			if (_canInit == false) { throw new Error('CommentRowPool is an singleton, and cannot be instaniated.'); }
			avilableRows = [];
		}
		
		public static function getRow(data:PostCommentData, user:FacebookUser):CommentRow { return getInstance().getRow(data, user); }
		protected function getRow(data:PostCommentData, user:FacebookUser):CommentRow {
			var row:CommentRow;
			
			if (avilableRows.length != 0) {
				row = avilableRows.pop() as CommentRow
			} else {
				row = new CommentRow();
			}
			
			row.setModel(data, user);
			if (_desktopHelper != null) { row.desktopHelper = _desktopHelper; }
			
			return row;
		}
		
		public static function addRow(row:CommentRow):void { getInstance().addRow(row); }
		protected function addRow(row:CommentRow):void {
			avilableRows.push(row);
		}
		
		public static function setDesktopHelper(helper:DesktopSessionHelper):void {
			_desktopHelper = helper;
		}
		
		protected static function getInstance():CommentRowPool {
			if (_instance == null) { _canInit = true; _instance = new CommentRowPool(); _canInit=false; }
			return _instance;
		}

	}
}