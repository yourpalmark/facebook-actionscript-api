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
	
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Rectangle;
	
	public class ScreenEdgeNotifier extends EventDispatcher {
		
		public static const SNAP_TOLERANCE:uint = 50;
		
		protected var _window:NativeWindow;
		protected var snapPoints:Array;
		protected var snapX:int;
		protected var winBounds:Rectangle;
		protected var withinTolerance:Boolean = false;
		protected var state:String = ScreenEdgeState.FREE
		protected var _snapEnabled:Boolean = false;
		
		public function set snapEnabled(p_bool:Boolean):void {
			_snapEnabled = p_bool;
			if(_snapEnabled) {
				trackWindow();
			} else {
				untrackWindow();
			}
		}
		
		public function get snapEnabled():Boolean {
			return _snapEnabled;
		}
		
		public function ScreenEdgeNotifier(p_window:NativeWindow) {
			super();
			_window = p_window;
			init();
		}
		
		protected function init():void {
			detectSnapPoints();
			//trackWindow();
		}
		
		protected function detectSnapPoints():void {
			snapPoints = [];
			var screens:Array = Screen.screens;
			var screen:Screen;
			var l:uint = screens.length;
			while(l--) {
				screen = screens[l] as Screen;
				var leftPoint:int = screen.visibleBounds.x;
				var rightPoint:int = screen.bounds.right - _window.width;
				snapPoints.push({ leftPoint: leftPoint, rightPoint:rightPoint, height:screen.bounds.height });
			}
		}
		
		protected function trackWindow():void {
			_window.addEventListener(NativeWindowBoundsEvent.MOVING, onWindowDrag, false, 0, true);
			_window.addEventListener(NativeWindowBoundsEvent.MOVE, onWindowMove, false, 0, true);
			_window.stage.addEventListener(MouseEvent.MOUSE_UP, onWindowDrop, false, 0, true);
		}
		
		protected function untrackWindow():void {
			_window.removeEventListener(NativeWindowBoundsEvent.MOVING, onWindowDrag);
			_window.removeEventListener(NativeWindowBoundsEvent.MOVE, onWindowMove);
			_window.stage.removeEventListener(MouseEvent.MOUSE_UP, onWindowDrop);
		}
		
		protected function onWindowDrag(p_event:NativeWindowBoundsEvent):void {
			winBounds = p_event.afterBounds;
			detectWithinTolerance();
		}
		
		protected function onWindowMove(p_event:NativeWindowBoundsEvent):void {
			detectSnapPoints();
		}
		
		protected function onWindowDrop(p_event:MouseEvent):void {
			if(state != ScreenEdgeState.FREE) {
				dispatchEvent(new ScreenEdgeEvent(ScreenEdgeEvent.SNAP, state, snapX));
			}
		}
		
		protected function detectWithinTolerance():void {
			var minX:int;
			var maxX:int;
			var xMouse:int = _window.stage.mouseX;
			var isWithinTolerance:Boolean = false;
			var currentState:String = "";
			var currentScreenHeight:Number;
			var l:uint = snapPoints.length;
			
			while (l--) {
				snapX = snapPoints[l].leftPoint;
				minX = snapX - xMouse;
				maxX = snapX + SNAP_TOLERANCE;
				currentScreenHeight = snapPoints[l].height;
				if((winBounds.x > minX) && (winBounds.x < maxX)) {
					isWithinTolerance = true;
					currentState = ScreenEdgeState.LEFT;
					break;
				} else {
					snapX = snapPoints[l].rightPoint;
					minX = snapX - SNAP_TOLERANCE;
					maxX = snapX + (winBounds.width - xMouse);
					if((winBounds.x > minX) && (winBounds.x < maxX)) {
						isWithinTolerance = true;
						currentState = ScreenEdgeState.RIGHT;
						break;
					}
				}
			}
			
			if (!isWithinTolerance) {
				currentState = ScreenEdgeState.FREE;
			} if (currentState != state) {
				state = currentState;
				var screenEdgeEvent:ScreenEdgeEvent;
				if(state == ScreenEdgeState.FREE) {
					screenEdgeEvent = new ScreenEdgeEvent(ScreenEdgeEvent.OUTSIDE_TOLERANCE);
				} else {
					screenEdgeEvent = new ScreenEdgeEvent(ScreenEdgeEvent.INSIDE_TOLERANCE, state, snapX, currentScreenHeight);
				}
				dispatchEvent(screenEdgeEvent);
			}
		}
	}
}