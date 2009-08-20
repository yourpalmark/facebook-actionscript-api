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
package com.facebook.data.photos {
	
	[Bindable]
	public class TagData {
		
		protected var _actualX:Number;
		protected var _actualY:Number;
		
		protected var _actualText:String;
		
		public var pid:String;
		public var subject:String;
		public var tag_uid:String;
		
		//Facebook returns xcoord and ycoord when getting tags
		//When sending tags facebook requires x & y.
		//So just treat both values as the same
		//Same for tag_text (sending), anf text (getting)
		
		public function set xcoord(value:Number):void { _actualX = value; }
		public function set ycoord(value:Number):void { _actualY = value; }
		public function set x(value:Number):void { _actualX = value; }
		public function set y(value:Number):void { _actualY = value; }
		
		public function get xcoord():Number { return _actualX; }
		public function get x():Number { return _actualX; }
		public function get ycoord():Number { return _actualY; }
		public function get y():Number { return _actualY; }
		
		public function set tag_text(value:String):void { _actualText = value; }
		public function get tag_text():String { return _actualText; }
		
		public function set text(value:String):void { _actualText = value; }
		public function get text():String { return _actualText; }
		
		public var created:Date;
		
		public function TagData() {
			
		}

	}
}