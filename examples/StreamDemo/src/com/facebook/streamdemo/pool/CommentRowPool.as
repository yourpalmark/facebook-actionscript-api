package com.facebook.streamdemo.pool {
	
	import com.facebook.data.stream.PostCommentData;
	import com.facebook.data.users.FacebookUser;
	import com.facebook.streamdemo.controls.CommentRow;
	
	public class CommentRowPool {
		
		protected static var _instance:CommentRowPool;
		protected static var _canInit:Boolean = false;
		
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
			
			return row;
		}
		
		public static function addRow(row:CommentRow):void { getInstance().addRow(row); }
		protected function addRow(row:CommentRow):void {
			avilableRows.push(row);
		}
		
		protected static function getInstance():CommentRowPool {
			if (_instance == null) { _canInit = true; _instance = new CommentRowPool(); _canInit=false; }
			return _instance;
		}

	}
}