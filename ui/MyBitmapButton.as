package com195z.ui 
{
	import com195z.ui.basic.IBasicUI;
	import com195z.ui.events.BitmapButtonEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * 位图按钮 弹起 经过 按下 3个状态
	 * @author wq
	 */
	public class MyBitmapButton extends Bitmap implements IBasicUI
	{
		public static const UP:int = 0;
		public static const OVER:int = 1;
		public static const DOWN:int = 2;
		
		private var _state:int;//当前状态
		
		private var _upState:BitmapData;//状态
		private var _overState:BitmapData;
		private var _downState:BitmapData;
		
		private var _callback:Function;//回调函数
		
		public function MyBitmapButton(upState:BitmapData, overState:BitmapData = null, downState:BitmapData = null, callback:Function = null) 
		{
			_state = UP;
			
			_upState = upState;
			_overState = overState;
			_downState = downState;
			
			_callback = callback;
			
			super(_upState);
			
			this.addEventListener(BitmapButtonEvent.CLICK, onClick);
			this.addEventListener(BitmapButtonEvent.UP, onUp);
			this.addEventListener(BitmapButtonEvent.OVER, onOver);
			this.addEventListener(BitmapButtonEvent.OUT, onOut);
			this.addEventListener(BitmapButtonEvent.DOWN, onDown);
		}
		
		//鼠标事件
		private function onClick(e:BitmapButtonEvent):void
		{
			if (_callback != null)
			{
				_callback();
			}
		}
		
		private function onUp(e:BitmapButtonEvent = null):void
		{
			this.bitmapData = _upState;
			_state = UP;
		}
		
		private function onOver(e:BitmapButtonEvent):void
		{
			if (_overState != null) this.bitmapData = _overState;
			_state = OVER;
		}
		
		private function onOut(e:BitmapButtonEvent):void
		{
			onUp();
		}
		
		private function onDown(e:BitmapButtonEvent):void
		{
			if (_downState != null) this.bitmapData = _downState;
			_state = DOWN;
		}
		
		//属性
		public function get state():int
		{
			return _state;
		}
		
		public function set callback(value:Function):void
		{
			_callback = value;
		}
		
		public function get callback():Function
		{
			return _callback;
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
		
		
		//清除数据
		public function dispose():void
		{
			this.removeEventListener(BitmapButtonEvent.CLICK, onClick);
			this.removeEventListener(BitmapButtonEvent.UP, onUp);
			this.removeEventListener(BitmapButtonEvent.OVER, onOver);
			this.removeEventListener(BitmapButtonEvent.OUT, onOut);
			this.removeEventListener(BitmapButtonEvent.DOWN, onDown);
		}
		
	}

}