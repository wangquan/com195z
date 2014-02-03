package com195z.ui.basic 
{
	import com195z.ui.basic.global.MyFilters;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	
	/**
	 * 基础窗口
	 * @author wq
	 */
	public class BasicWindow extends BasicContainer
	{
		private var _background:Bitmap;//背景
		private var _title:BasicTextField;//标题
		
		public function BasicWindow(data:BitmapData, text:String) 
		{
			this.mouseChildren = true;
			
			_background = new Bitmap(data);
			
			_title = new BasicTextField();
			_title.mouseEnabled = false;
			_title.filters = MyFilters.BLACK_GLOW;
			_title.autoSize = TextFieldAutoSize.CENTER;
			_title.htmlText = "<title>" + text + "</title>";
			_title.x = _background.width - _title.width >> 1;
			
			this.addChild(_background);
			this.addChild(_title);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		//鼠标事件
		private function onMouseDown(e:MouseEvent):void
		{
			if (e.localY < _title.height && e.target === this)
			{
				this.startDrag();
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		
		//属性
		public function get title():BasicTextField
		{
			return _title;
		}
		
		
		//清除数据
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_title.dispose();
			
		}
		
	}

}