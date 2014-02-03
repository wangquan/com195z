package com195z.ui 
{
	import com195z.ui.basic.BasicContainer;
	import com195z.ui.basic.BasicTextField;
	import com195z.ui.basic.global.MyFilters;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	
	/**
	 * 基础按钮 四个状态 弹起 悬停 按下 禁用
	 * @author wq
	 */
	public class MyButton extends BasicContainer
	{
		private var _textField:BasicTextField;//按钮文字
		
		private var _background:Bitmap;//按钮背景
		private var _upState:BitmapData;
		private var _overState:BitmapData;
		private var _downState:BitmapData;
		private var _disenabledState:BitmapData;
		
		private var _oWidth:Number;//缩放前的原始值
		private var _oHeight:Number;
		
		private var _enabled:Boolean;//启用 激活状态
		
		private var _callback:Function;//回调函数
		
		public function MyButton(upState:BitmapData, text:String = "", overState:BitmapData = null, downState:BitmapData = null, disenabledState:BitmapData = null, callback:Function = null) 
		{
			super();
			this.buttonMode = true;
			
			_upState = upState;
			_overState = overState;
			_downState = downState;
			_disenabledState = disenabledState;
			
			_callback = callback;
			
			_background = new Bitmap(_upState);
			this.addChild(_background);
			
			_oWidth = this.width;
			_oHeight = this.height;
			
			_enabled = true;
			
			if (text != "" && text != null)
			{
				_textField = new BasicTextField();
				_textField.mouseEnabled = false;
				_textField.autoSize = TextFieldAutoSize.CENTER;
				_textField.filters = MyFilters.BLACK_GLOW;
				_textField.htmlText = "<button>" + text + "</button>";
				_textField.x = _background.width - _textField.width >> 1;
				_textField.y = _background.height - _textField.height >> 1;
				
				this.addChild(_textField);
			}
			
			//添加事件
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		//鼠标事件
		private function onUp(e:MouseEvent = null):void
		{
			_background.bitmapData = _upState;
			if (_background.scaleX != 1)
			{
				_background.scaleX = _background.scaleY = 1;
				_background.x = _background.y = 0;
			}
		}
		
		private function onOver(e:MouseEvent):void
		{
			if (_overState != null) _background.bitmapData = _overState;
		}
		
		private function onOut(e:MouseEvent):void
		{
			onUp();//还原弹起状态
		}
		
		private function onDown(e:MouseEvent):void
		{
			if (_downState != null)
			{
				_background.bitmapData = _downState;
			}else
			{
				_background.scaleX = _background.scaleY = 0.9;
				_background.x = _oWidth - _background.width >> 1;
				_background.y = _oHeight - _background.height >> 1;
			}
		}
		
		private function onClick(e:MouseEvent):void
		{
			if (_callback != null)
			{
				_callback();
			}
		}
		
		//属性
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			if (_enabled)
			{
				this.mouseEnabled = true;
				onUp();
			}else
			{
				this.mouseEnabled = false;
				if (_disenabledState != null) _background.bitmapData = _disenabledState;
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		//文字
		public function get textField():BasicTextField
		{
			return _textField;
		}
		
		//图片资源
		public function set upState(value:BitmapData):void
		{
			_upState = value;
			onUp();//更新
		}
		
		public function get upState():BitmapData
		{
			return _upState;
		}
		
		public function set overState(value:BitmapData):void
		{
			_overState = value;
		}
		
		public function get overState():BitmapData
		{
			return _overState;
		}
		
		public function set downState(value:BitmapData):void
		{
			_downState = value;
		}
		
		public function get downState():BitmapData
		{
			return _downState;
		}
		
		public function set disenabledState(value:BitmapData):void
		{
			_disenabledState = value;
		}
		
		public function get disenabledState():BitmapData
		{
			return _disenabledState;
		}
		
		//回调函数
		public function set callback(value:Function):void
		{
			_callback = value;
		}
		
		public function get callback():Function
		{
			return _callback;
		}
		
		
		//清除数据
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			this.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.removeEventListener(MouseEvent.CLICK, onClick);
			
			_textField.dispose();
		}
		
	}

}