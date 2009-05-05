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
package com.facebook.streamdemo.ui {
	
	import flash.text.StyleSheet;
	
	public class Styles {
		
		protected static var _instance:Styles;
		protected static var _canInit:Boolean = false;
		
		protected var styleSheetMap:Object;
		
		protected static var FONT:String = 'Lucida Grande';
		
		public function Styles() {
			if (_canInit == false) { throw new Error('Class Styles is a singleton and cannot be initilized.'); }
			
			initilizeStyleSheets();
		}
		
		protected function initilizeStyleSheets():void {
			var storyTitleSheet:StyleSheet = new StyleSheet();
			storyTitleSheet.setStyle('a', {color:'#3b5998', fontWeight:'bold', fontName:FONT});
			storyTitleSheet.setStyle('a:hover', {textDecoration:'underline'});
			storyTitleSheet.setStyle('.content', {kerning:true, fontWeight:'normal',color:'#333333',fontName:FONT});
			storyTitleSheet.setStyle('.url', {color:'#3b5998', fontWeight:'normal', fontName:FONT});
			
			var commentTitleSheet:StyleSheet = new StyleSheet();
			commentTitleSheet.setStyle('a', {color:'#3b5998', fontWeight:'bold', fontName:FONT});
			commentTitleSheet.setStyle('a:hover', {textDecoration:'underline'});
			commentTitleSheet.setStyle('.content', {kerning:true, fontWeight:'normal',color:'#5E5E5E',fontName:FONT});
			
			styleSheetMap = {
				storyTitle:storyTitleSheet,
				commentTitle:commentTitleSheet	
			}
		}
		
		public static function getStyleSheet(p_styleName:String):StyleSheet {
			return getInstance().styleSheetMap[p_styleName];
		}
		
		public static function setStyleSheet(p_component:Object, p_styleName:String):void {
			getInstance().setStyleSheet(p_component, p_styleName);
		}
		
		protected function setStyleSheet(p_component:Object, p_styleName:String):void {
			if ('styleSheet' in p_component) {
				p_component.styleSheet = styleSheetMap[p_styleName];
			}
		}
		
		protected static function getInstance():Styles {
			if (_instance == null) { _canInit = true; _instance = new Styles(); _canInit = false; }
			return _instance;
		}
	}
}