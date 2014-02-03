package com195z.ui.basic.global 
{
	import flash.text.StyleSheet
	
	/**
	 * 全局样式
	 * @author wq
	 */
	public class MyStyleSheet 
	{
		[Embed(source = "globalStyleSheet.min.css", mimeType = "application/octet-stream")]
		private var GlobalStyleSheet:Class;
		
		private static var _myStyleSheet:MyStyleSheet;
		private var _styleSheet:StyleSheet;
		
		public function MyStyleSheet(key:MyStyleSheetKey) 
		{
			if (key == null) throw new Error("Singleton!");
			_myStyleSheet = this;
			_styleSheet = new StyleSheet();
			_styleSheet.parseCSS(new GlobalStyleSheet());
		}
		
		//获取样式单例
		public static function manager():MyStyleSheet
		{
			if (_myStyleSheet == null) 
			{
				_myStyleSheet = new MyStyleSheet(new MyStyleSheetKey());
			}
			return _myStyleSheet;
		}
		
		//属性
		public function get styleSheet():StyleSheet
		{
			return _styleSheet;
		}
		
		//清除数据
		public function dispose():void
		{
			_myStyleSheet = null;
		}
		
	}

}

class MyStyleSheetKey
{
	
}