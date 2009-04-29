package com.facebook.streamdemo.pool {
	import com.facebook.streamdemo.controls.StreamRow;
	import com.facebook.streamdemo.data.StreamData;
	
	
	public class StreamRowPool {
		
		protected static var _instance:StreamRowPool;
		protected static var _canInit:Boolean = false;
		
		protected var avilableRows:Array;
		
		public function StreamRowPool() {
			if (_canInit == false) { throw new Error('StreamRowPool is an singleton, and cannot be instaniated.'); }
			avilableRows = [];
		}
		
		public static function getRow(data:StreamData):StreamRow { return getInstance().getRow(data); }
		public function getRow(data:StreamData):StreamRow {
			var row:StreamRow;
			
			if (avilableRows.length != 0) {
				row = avilableRows.pop() as StreamRow
			} else {
				row = new StreamRow();
			}
			
			row.setModel(data);
			
			return row;
		}
		
		public static function addRow(data:StreamRow):void { getInstance().addRow(data); }
		public function addRow(row:StreamRow):void {
			avilableRows.push(row);
		}
		
		protected static function getInstance():StreamRowPool {
			if (_instance == null) { _canInit = true;  _instance = new StreamRowPool(); _canInit = false; }
			return _instance;
		}

	}
}