package com195z.ui 
{
	import com195z.ui.basic.BasicContainer;
	import com195z.ui.basic.BasicTextField;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * 提示
	 * @author wq
	 */
	public class MyTips extends BasicContainer
	{
		private var _background:Bitmap;//背景
		private var _content:BasicTextField;//文字
		
		private var _width:int;//固定宽
		private var _oldHeight:int;
		private var _backColor:uint;
		private var _borderColor:uint;
		private var _border:int;
		
		public function MyTips(data:BitmapData = null, width:int = 200, backColor:uint = 0xf6e7bc, border:int = 2, borderColor:uint = 0x926457)
		{
			super();
			this.mouseEnabled = false;
			
			_width = width;
			_oldHeight = 0;
			_backColor = backColor;
			_borderColor = borderColor;
			_border = border;
			
			if (data != null)
			{
				_background = new Bitmap(data);
				_width = _background.width;
				this.addChild(_background);
			}
			
			_content = new BasicTextField();
			_content.mouseEnabled = false;
			_content.autoSize = TextFieldAutoSize.LEFT;
			_content.width = _width - _border * 2;
			_content.x = _border;
			_content.y = _border;
			updata("");
			
			this.addChild(_content);
		}
		
		//更新文字
		public function updata(str:String):void
		{
			_content.htmlText = str;
			if (_background == null && _oldHeight != _content.height)
			{
				drawBackground();
				_oldHeight = _content.height;
			}
		}
		
		//绘制背景
		private function drawBackground():void
		{
			this.graphics.clear();
			this.graphics.beginFill(_backColor);
			
			this.graphics.lineStyle(_border, _borderColor);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(_width, 0);
			this.graphics.lineTo(_width, _content.height + _border * 2);
			this.graphics.lineTo(0, _content.height + _border * 2);
			this.graphics.lineTo(0, 0);
			
			this.graphics.endFill();
		}
		
		
		//清除数据
		override public function dispose():void
		{
			super.dispose();
			
			_content.dispose();
		}
		
	}

}