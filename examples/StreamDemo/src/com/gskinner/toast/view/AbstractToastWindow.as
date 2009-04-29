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
package com.gskinner.toast.view {
	import com.gskinner.motion.GTween;
	import com.gskinner.toast.ToastManager;
	import com.gskinner.toast.data.NotificationData;
	import com.gskinner.toast.events.ToastEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.core.Window;
			
	public class AbstractToastWindow extends Window {
		
		public var ignoreTick:Boolean = true;
		public var timeToLive:uint;
		
		protected var toastTween:GTween;
		protected var animate:Boolean;
		protected var windowWidth:Number;
		protected var windowHeight:Number;
		protected var _notificationData:NotificationData;
		protected var closeNotification:Button;
		protected var notificationDataChanged:Boolean;
		
		public function AbstractToastWindow() {
			configUI();
		}
		
		public function show():void {
			toastTween.setProperties({alpha:1});
            toastTween.addEventListener(Event.COMPLETE, onToastShown, false, 0, true);
            toastTween.play();
		}
		
		public function set notificationData(value:NotificationData):void {
			notificationDataChanged = true;
			_notificationData = value;
			invalidateProperties();
		}
		
		public function closeWindow(p_animate:Boolean=true):void {
			animate = p_animate;
			close();
		}
		
		override public function close():void {
			if (animate) {
				if (toastTween == null) { 
					return; 
				}
				
				if (toastTween.state == GTween.TWEEN){
					closeNotification.enabled = false;
					return; 
				}
				
				toastTween.setProperties({alpha:0});
	            toastTween.addEventListener(Event.COMPLETE, onToastHidden, false, 0, true);
	            toastTween.play();
	  		} else {
	  			super.close();
	  		}
		}
		
		override public function set width(value:Number):void {
			windowWidth = value + 5;
			super.width = windowWidth;
		}
		
		override public function set height(value:Number):void {
			windowHeight = value + 5;
			super.height = windowHeight;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			createCloseButton();
		}
		
		protected function configUI():void {
			ToastManager.getInstance().addEventListener(ToastEvent.TICK, onTick, false, 0, true);
			toastTween = new GTween(this, 0.30, {}, {autoPlay: false});
		}
		
		protected function createCloseButton():void {
			closeNotification = new Button();
			closeNotification.width = 10;
			closeNotification.height = 10;
			closeNotification.useHandCursor = true; 
			closeNotification.buttonMode = true;  
			closeNotification.toolTip = "Close"; 
			closeNotification.styleName = "closeButton"; 
			closeNotification.x = this.width - 20/*(buttonWidth)*/;
			closeNotification.y = 5;
			closeNotification.addEventListener(MouseEvent.MOUSE_UP, closeToastWindow, false, 0, true);
			addChild(closeNotification);
		}
		
		
		protected function closeToastWindow(p_event:MouseEvent):void {
			closeWindow();
		}
		
		protected function onToastShown(p_event:Event):void {
			dispatchEvent(new Event(Event.COMPLETE, true, false));
			toastTween.removeEventListener(Event.COMPLETE, onToastShown);
		}
		
		protected function onToastHidden(p_event:Event):void {
			toastTween.removeEventListener(Event.COMPLETE, onToastHidden);
			super.close();
		}
		
		protected function onTick(p_event:ToastEvent):void {
			if (!ignoreTick) { 
				timeToLive--;
				if (timeToLive == 0) {
					ignoreTick = true;
					closeWindow();
				}
			}
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			if(notificationDataChanged){ 
				drawContent();
				notificationDataChanged = false;
			}	
		}
		
		protected function drawContent():void { }

	}
}