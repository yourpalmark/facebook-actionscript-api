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
	
	import com.gskinner.motion.GTween;
	import com.gskinner.utils.CallLater;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	import mx.effects.easing.Sine;
	
	public class ScreenEdgeHelper extends EventDispatcher {
		
		public static const AUTO_HIDE_TWEEN_DURATION:Number = 0.35; // seconds
		public static const AUTO_HIDE_DELAY:uint = 10; // milliseconds
		
		protected var screenEdgeNotifier:ScreenEdgeNotifier;
		protected var screenEdgeWindow:ScreenEdgeWindow;
		protected var autoHideTween:GTween;
		protected var autoHideTimer:Timer;
		protected var _snapSide:String = ScreenEdgeState.FREE;
		protected var _hidden:Boolean = false;
		protected var autoHideEnabled:Boolean = false;
		
		protected var canvas:UIComponent;
		protected var window:NativeWindow;
		
		public function ScreenEdgeHelper(canvas:UIComponent, window:NativeWindow) {
			this.canvas = canvas;
			this.window = window;
			
			initScreenEdgeWindow();
			initAutoHide();
			
			screenEdgeNotifier = new ScreenEdgeNotifier(window);
			screenEdgeNotifier.addEventListener(ScreenEdgeEvent.OUTSIDE_TOLERANCE, onOutsideTolerance,false, 0, true);
			screenEdgeNotifier.addEventListener(ScreenEdgeEvent.INSIDE_TOLERANCE, onInsideTolerance,false, 0, true);
			screenEdgeNotifier.addEventListener(ScreenEdgeEvent.SNAP, onSnap,false, 0, true);
		}
		
		public function get hidden():Boolean { return _hidden; }
		public function get snapSide():String { return _snapSide; }
		
		public function set autoHide(value:Boolean):void {
			autoHideEnabled = value;
		}
		
		public function set snapEnabled(value:Boolean):void {
			screenEdgeNotifier.snapEnabled = value;
		}
		
		protected function initScreenEdgeWindow():void {
			screenEdgeWindow = new ScreenEdgeWindow();
			screenEdgeWindow.mouseEnabled = false;
			screenEdgeWindow.open();
		}
		
		protected function initAutoHide():void {
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate, false, 0, true);
			
			GTween.timingMode = GTween.HYBRID;
			
			autoHideTween = new GTween(canvas, AUTO_HIDE_TWEEN_DURATION);
			autoHideTween.ease = Sine.easeIn;
			
			autoHideTimer = new Timer(AUTO_HIDE_DELAY, 1);
			autoHideTimer.addEventListener(TimerEvent.TIMER_COMPLETE, toggleAutoHide, false, 0, true);
		}
		
		protected function onOutsideTolerance(p_event:ScreenEdgeEvent):void {
			disableAutoHide();
			canvas.alpha = 1;
			screenEdgeWindow.orderToFront();
			CallLater.call(hideScreenEdgeWindow, 2);
			_snapSide = ScreenEdgeState.FREE;
		}
		
		public function hideScreenEdgeWindow():void {
			screenEdgeWindow.hide();
		}
		
		protected function onInsideTolerance(p_event:ScreenEdgeEvent):void {
			_snapSide = p_event.snapSide;
			hideScreenEdgeWindow();
			canvas.alpha = 0.5;
			screenEdgeWindow.nativeWindow.y = 0;
			screenEdgeWindow.height = p_event.screenHeight;
			var screenEdgeX:int = (p_event.snapSide == ScreenEdgeState.LEFT) ? p_event.snapX : p_event.snapX + (window.width - screenEdgeWindow.width);
			screenEdgeWindow.show(screenEdgeX, p_event.snapSide);
		}
		
		protected function onSnap(p_event:ScreenEdgeEvent):void {
			_snapSide = p_event.snapSide;
			hideScreenEdgeWindow();
			window.x = (_snapSide ==ScreenEdgeState.LEFT) ? p_event.snapX - 1 : p_event.snapX;
			window.alwaysInFront = true;
			screenEdgeWindow.orderToFront();
			canvas.alpha = 1;
		}
		
		public function toggleAutoHide(p_event:TimerEvent):void { 
			if(!autoHideEnabled) { return; }
			
			var endX:int;
			
			if (_snapSide == ScreenEdgeState.LEFT) {
				if(_hidden) {			// left, _hidden
					endX = 0;
					_hidden = false;
				} else {				// left, visible
					endX = -window.width;
					_hidden = true;
				}
			} else {
				if(_hidden) {			// right, _hidden
					endX = 0;
					_hidden = false;
				} else { 				// right, visible
					endX = window.width;
					_hidden = true;
				}
			}
			
			autoHideTween.setProperty('x', endX);
			autoHideTween.addEventListener(Event.COMPLETE, onTweenComplete, false, 0, true);
			autoHideTween.play();
		}
		
		protected function onTweenComplete(p_event:Event):void {
			if(_hidden) {
				screenEdgeWindow.mainCanvas.addEventListener(MouseEvent.ROLL_OVER, onEdgeWindowOver, false, 0, true);
			} else {
				dispatchEvent(new ScreenEdgeEvent(ScreenEdgeEvent.ENABLE));
			}
			
			screenEdgeWindow.orderToFront();
		}
		
		protected function onEdgeWindowOver(p_event:Event):void {
			dispatchEvent(new ScreenEdgeEvent(ScreenEdgeEvent.DISABLE));
			autoHideTimer.reset();
			autoHideTimer.start(); // TIMER_COMPLETE executes toggleAutoHide();
			disableAutoHide();
		}
		
		protected function disableAutoHide():void {
			if (_hidden) {
				screenEdgeWindow.mainCanvas.removeEventListener(MouseEvent.ROLL_OVER, onEdgeWindowOver);
			}
		}
		
		protected function onDeactivate(p_event:Event):void {
			if((!_hidden) && (_snapSide != ScreenEdgeState.FREE)) {	
				toggleAutoHide(null);
			}
		}
		
	}
}