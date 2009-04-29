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
package com.gskinner.toast {
	
	import com.gskinner.motion.GTween;
	import com.gskinner.toast.data.NotificationData;
	import com.gskinner.toast.events.ToastEvent;
	import com.gskinner.toast.view.AbstractToastWindow;
	import com.gskinner.toast.view.BaseToastWindow;
	
	import flash.display.Screen;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	
	public class ToastManager extends EventDispatcher {
		
		protected static var _instance:ToastManager;
		protected const gutter:int = 10;
		
		protected var tickTimer:Timer;
		protected var currentScreen:Screen;
		protected var toastHash:Dictionary;
		protected var visibleHash:Dictionary;
		protected var toastQueue:Array;
		protected var toastCount:uint;
		protected var tween:GTween;
		protected var _maxVisible:uint = 4; 
		protected var visibleCount:uint;
		protected var TTL:uint;
		protected var shouldClose:Boolean;
		protected var paused:Boolean;
		
		public function ToastManager() {
			paused = false;
			
			visibleHash = new Dictionary(false);
			toastHash = new Dictionary(false);
			toastQueue = [];
			
			tickTimer = new Timer(1000);
			tickTimer.addEventListener(TimerEvent.TIMER, onTick, false, 0, true);
		}
		
		public static function addNotification(p_data:NotificationData=null, p_duration:uint=5, p_width:Number=166, p_height:Number=80, p_toastWindowRenderer:AbstractToastWindow=null):void { getInstance().addNotification(p_data, p_duration, p_width, p_height, p_toastWindowRenderer);}
		protected function addNotification(p_data:NotificationData, p_duration:uint, p_width:Number, p_height:Number, p_toastWindowRenderer:AbstractToastWindow):void {
			var toastWindowRenderer:AbstractToastWindow = p_toastWindowRenderer;
			if (toastWindowRenderer == null) { toastWindowRenderer = new BaseToastWindow(); }
			toastWindowRenderer.width = p_width;
			toastWindowRenderer.height = p_height;

			if (p_duration > -1 && p_duration <= 5) { TTL = 5; } else { TTL = p_duration; }
			addToast(p_data, toastWindowRenderer);
		}
		
		public static function getInstance():ToastManager {
			if(_instance == null) {_instance = new ToastManager(); }
			return _instance;
		}
		
		public static function set maxVisible(p_maxVisible:uint):void { getInstance()._maxVisible = p_maxVisible }
		public static function get maxVisible():uint { return getInstance()._maxVisible }
		
		public static function get notificationQueue():Array { return getInstance().notificationQueue }
		protected function get notificationQueue():Array {
			return toastQueue;
		}
		
		public function getToastWindow(p_data:NotificationData):AbstractToastWindow { return toastHash[p_data];	}
		
		public static function closeAll():void { getInstance().closeAll(); }
		protected function closeAll():void {
			shouldClose = true;
			toastQueue.length = 0;
			for (var notificationData:* in visibleHash){
				var toastWin:AbstractToastWindow = getToastWindow(notificationData);
				toastWin.closeWindow(false);
				visibleHash[notificationData] = null;
				delete visibleHash[notificationData];
			}
		}
		
		public static function pause():void { getInstance().pause(); }
		protected function pause():void {
			paused = true;
			tickTimer.stop();
		}
		
		public static function play():void { getInstance().play(); }
		protected function play():void {
			paused = false;
			var l:Number = toastQueue.length;
			var activeToasts:Boolean = hasActiveToast();
			
			if (!tickTimer.running && l > 0){
				tickTimer.reset();
				tickTimer.start();
				showNext();
			} else if (l == 0 && activeToasts){
				tickTimer.reset();
				tickTimer.start();
			}
			
		}
		
		protected function addToast(p_data:NotificationData, p_toastWindowRenderer:AbstractToastWindow):void {
			if (!toastHash[p_data]) {
				var toastData:ToastData = new ToastData(p_data, p_toastWindowRenderer);
				toastQueue.push(toastData);
				showNext();
			}
		}
		
		protected function showNext():void {
			if (toastQueue.length == 0 || paused) { return; }
			
			if (visibleCount < _maxVisible) {
				var toastData:ToastData = toastQueue.shift() as ToastData;
				createToast(toastData.data, toastData.renderer);
			}
			
		}
		
		protected function createToast(p_data:NotificationData, p_toastWindowRenderer:AbstractToastWindow):void {
			visibleCount++;
			
			var toastWin:AbstractToastWindow = p_toastWindowRenderer;
			
			toastWin.notificationData = p_data;
			toastWin.open(false);
			
			toastHash[p_data] = toastWin;
			visibleHash[p_data] = toastWin;
			
			toastWin.nativeWindow.x = toastWin.nativeWindow.y = -3000;
			toastWin.addEventListener(FlexEvent.CREATION_COMPLETE, showToast, false, 0, true);
			
		}
		
		protected function findSpotForToast(p_size:Rectangle):Point {
			var appScreen:Screen = Screen.mainScreen;
			
			var scrs:Array = [appScreen];
			var spot:Point = new Point();
			loop: for each(var screen:Screen in scrs) {
				currentScreen = screen;
				for(var x:int = screen.visibleBounds.x + screen.visibleBounds.width - p_size.width - gutter; x >= screen.visibleBounds.x; x -= (p_size.width + gutter)){
					for(var y:int = screen.visibleBounds.y + gutter; y < screen.visibleBounds.height; y += (p_size.height + gutter)){
						var testRect:Rectangle = new Rectangle(x, y, p_size.width + gutter, p_size.height + gutter);
						if(!isOccupied(testRect) && (y+p_size.height < screen.visibleBounds.height)){
							spot.x = x;
							spot.y = y;
							break loop;
						}
					}
				
				}
			
			}
			return spot;
		}
		
		protected function showToast(p_event:FlexEvent):void {
			var toastWin:AbstractToastWindow = p_event.target as AbstractToastWindow;
			
			if(shouldClose) { 
				toastWin.closeWindow(false); 
				return;
			}
			
			toastWin.ignoreTick = false;
			toastWin.timeToLive = TTL;
			
			toastWin.removeEventListener(FlexEvent.CREATION_COMPLETE, showToast);
			toastWin.addEventListener(Event.CLOSE, closeToast, false, 0, true);
			toastWin.addEventListener(MouseEvent.ROLL_OVER, onEnterWindow, false, 0, true);
			toastWin.addEventListener(MouseEvent.ROLL_OUT, onExitWindow, false, 0, true);
			
			var appScreen:Screen = Screen.mainScreen;
			toastWin.alpha = 0;
			
			var toastPos:Point = findSpotForToast(toastWin.nativeWindow.bounds);
            toastWin.nativeWindow.y = toastPos.y;          
            toastWin.nativeWindow.x = toastPos.x;
            
           	toastWin.addEventListener(Event.COMPLETE, onToastShown, false, 0, true);
           	toastWin.show();
		}
		
		protected function onToastShown(p_event:Event):void {
			var toastWin:AbstractToastWindow = p_event.target as AbstractToastWindow;
			toastWin.removeEventListener(Event.COMPLETE, onToastShown);
			
			if (toastQueue.length >= 1) {
				showNext();            	
			}
			
			if (!tickTimer.running && hasActiveToast() && !paused) {
				tickTimer.reset();
				tickTimer.start();
			}
		}
		
		protected function onEnterWindow(p_event:MouseEvent):void { 
			var toastWin:AbstractToastWindow = p_event.target as AbstractToastWindow;
			toastWin.ignoreTick = true;
			toastWin.activate();
		}
		
		protected function onExitWindow(p_event:MouseEvent):void { 
			var toastWin:AbstractToastWindow = p_event.target as AbstractToastWindow;
			toastWin.ignoreTick = false; 
		}
		
		
		protected function closeToast(p_event:Event):void {
			var toastWin:AbstractToastWindow = p_event.target as AbstractToastWindow;
			toastWin.ignoreTick = true;
			
			for (var notificationData:* in toastHash) {
				var toastWinLookUp:AbstractToastWindow = getToastWindow(notificationData);
				if (toastWin == toastWinLookUp){
					toastWin = null;
			        
			        visibleHash[notificationData] = null;
			        toastHash[notificationData] = null;
			        
			        delete toastHash[notificationData]; 
			        delete visibleHash[notificationData];
					
		            if (tickTimer.running && !hasActiveToast()) {
						tickTimer.stop();
					}
				}
			}
			
			visibleCount--;
			showNext();
			    
		}
		
		protected function isOccupied(testRect:Rectangle):Boolean{
			var occupied:Boolean = false;
			for (var toastData:* in toastHash){
				var toastWin:AbstractToastWindow = getToastWindow(toastData as NotificationData);
				occupied = toastWin.nativeWindow.bounds.intersects(testRect) || occupied;
			}
			return occupied;
		}
		
		protected function hasActiveToast():Boolean {
			var hasToast:Boolean = false;
			for each (var data:* in toastHash) { hasToast = true; break; }
			return hasToast;
		}
		
		protected function onTick(p_event:TimerEvent):void {
			dispatchEvent(new ToastEvent(ToastEvent.TICK, true, false));
		}
		
	}
}
	import com.gskinner.toast.data.NotificationData;
	import com.gskinner.toast.view.AbstractToastWindow;
	

class ToastData {
	
	public var data:NotificationData;
	public var renderer:AbstractToastWindow;
	
	public function ToastData(p_data:NotificationData, p_toastWindowRenderer:AbstractToastWindow){
		data = p_data;
		renderer = p_toastWindowRenderer;
	}
}