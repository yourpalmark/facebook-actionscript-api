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