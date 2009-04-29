/**
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
* Copyright (c) 2009 Grant Skinner
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
**/
package com.gskinner.screen {
	
	import flash.events.Event;
	
	public class ScreenEdgeEvent extends Event {
		
		public static const INSIDE_TOLERANCE:String = "insideTolerance";
		public static const OUTSIDE_TOLERANCE:String = "outsideTolerance";
		public static const SNAP:String = "snap";
		public static const ENABLE:String = 'enable';
		public static const DISABLE:String = 'disable';
		
		public var snapX:int;
		public var snapSide:String;
		public var screenHeight:Number;
		
		public function ScreenEdgeEvent(p_type:String, p_snapSide:String = null, p_snapX:int = -1, screenHeight:Number = NaN) {
			super(p_type);
			
			snapSide = p_snapSide;
			snapX = p_snapX;
			this.screenHeight = screenHeight;
		}
		
		override public function clone():Event { return new ScreenEdgeEvent(type, snapSide, snapX, screenHeight); }
	}
}
