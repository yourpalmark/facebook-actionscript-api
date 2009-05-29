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
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Distractor extends Sprite {
		
		public var fadeDuration:Number = 800;
		
		protected var tf:TextField; 
    	protected var dots:Sprite;
		protected var dotWidth:Number = 40;
	    protected var dotHeight:Number = 20;
    	protected var totalElapsed:Number = 0;
    	protected var _text:String;
		
		public function Distractor() {			
			super();			
			configUI();
		}
		protected function configUI():void {
			
			var format:TextFormat = new TextFormat("_sans", 11);			
			
			tf = new TextField();
			tf.selectable = false;
			tf.defaultTextFormat = format;
			addChild(tf);
			
			dots = new Sprite();
			addChild(dots);			
			dots.x = tf.width;
			
			addEventListener(Event.ENTER_FRAME, onTick, false, 0, true);
		}
		
		public function set text(value:String):void {
			tf.text = value;
			tf.width = tf.textWidth + 10;
			dots.x = tf.width;
		}
		
		public function get text():String {
			return tf.text;
		}
		
		override public function set visible(value:Boolean):void {
			if (super.visible == value) { return; }
			
			super.visible = value;
			
			if (visible) {
				addEventListener(Event.ENTER_FRAME, onTick, false, 0, true);
			} else {
				removeEventListener(Event.ENTER_FRAME, onTick);
			}
		}
		
		protected function clamp(n:Number, min:Number=0, max:Number=1):Number {
			if(n < min){ return min; }
			if(n > max){ return max; }
			return n;
		}
		
		protected function invCos(x:Number):Number {
			return 1 - (0.5 * (Math.cos(x*Math.PI) + 1));
	    }
		
		protected function onTick(event:Event):void {			
			totalElapsed += 20;

			var cycle:Number;
			dots.graphics.clear();
			
			var fullHeight:Number = Math.floor(dotHeight);
			var restHeight:Number = Math.floor(fullHeight * 0.3);
			
			var shapeWidth:Number = Math.round((dotWidth/3) * 0.6);
			var shapeGap:Number = Math.round((dotWidth/3) * 0.4);
			
			var dH:Number = fullHeight - restHeight;
			for(var i:int=0; i<3; i++){
				cycle = (totalElapsed + (3-i) * fadeDuration*0.13) % fadeDuration;
				cycle = invCos(1 - clamp(cycle/(0.6*fadeDuration)));

				dots.graphics.lineStyle(1, 0x576EA4, cycle*0.7+0.3, true);
				dots.graphics.beginFill(0xB1BAD3, cycle*0.7+0.3);
				dots.graphics.drawRoundRect(0.5 + i * (shapeGap + shapeWidth), 0.5 + 0.5 * (dH - cycle*dH), shapeWidth, restHeight + cycle * dH, 2);
				dots.graphics.endFill();
			}
		}
	}
}