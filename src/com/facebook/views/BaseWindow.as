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
package com.facebook.views {
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowType;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	public class BaseWindow extends NativeWindow {
		
		public static const DEFAULT_WIDTH:Number = 640;
		public static const DEFAULT_HEIGHT:Number = 480;
		public static const PADDING:Number = 20;
		
		protected var _html:HTMLLoader;
		protected var distractor:Distractor;
		protected var urlVars:URLVariables;
		protected var req:URLRequest;
		
		public function BaseWindow(){
			var winInit:NativeWindowInitOptions = new NativeWindowInitOptions();
			winInit.type = NativeWindowType.UTILITY;
			winInit.resizable = false;
			winInit.maximizable = false;
			super(winInit);
			
			//native window
			activate();
			alwaysInFront = true;
			addEventListener(Event.CLOSING, onClosing, false, 0, true);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			width = DEFAULT_WIDTH;
			height = DEFAULT_HEIGHT;
			
			//html loader
			_html = new HTMLLoader();
			stage.addChild(_html);			
			_html.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			_html.addEventListener(Event.LOCATION_CHANGE, onLocationChange, false, 0, true);			
			
			//distractor
			distractor = new Distractor();			
			stage.addChild(distractor);
			/* distractor.text = "Please Wait";
			distractor.x = width - distractor.width >> 1;
			distractor.y = height - distractor.height >> 1;	 */					
			
			urlVars = new URLVariables();
			req = new URLRequest();
			req.data = urlVars;
		}
		
		public function get html():HTMLLoader {
			return _html;
		}
		
		protected function onComplete(event:Event):void {
			distractor.visible = false; //also removes the ENTER_FRAME listener on the distractor
			_html.width = DEFAULT_WIDTH;
			_html.height = DEFAULT_HEIGHT;
		}
		
		protected function onLocationChange(event:Event):void {
			_html.width = _html.height = 0;
			distractor.visible = true;
		}
		
		protected function onClosing(event:Event):void {}
	}
}