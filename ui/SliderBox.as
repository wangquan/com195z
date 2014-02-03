package com195z.ui 
{
	import com195z.ui.basic.BasicContainer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	/**
	 * 滑块
	 * @author wq
	 */
	public class SliderBox extends BasicContainer
	{
		public static const HORIZONTAL:int = 0;//滑动方向
		public static const VERTICAL:int = 1;
		
		private var _background:Bitmap;//按钮背景
		private var _upState:BitmapData;
		private var _overState:BitmapData;
		private var _downState:BitmapData;
		
		public function SliderBox(upState:BitmapData, overState:BitmapData = null, downState:BitmapData = null) 
		{
			super();
			this.buttonMode = true;
			
			_upState = upState;
			_overState = overState;
			_downState = downState;
			
			_background = new Bitmap(_upState);
			
			this.addChild(_background);
			
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
		}
		
		//鼠标事件
		private function onUp(e:MouseEvent = null):void
		{
			_background.bitmapData = _upState;
		}
		
		private function onOver(e:MouseEvent):void
		{
			if (_overState != null) _background.bitmapData = _overState;
		}
		
		private function onOut(e:MouseEvent):void
		{
			onUp();
		}
		
		private function onDown(e:MouseEvent):void
		{
			if (_downState != null) _background.bitmapData = _downState;
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
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			this.removeEventListener(MouseEvent.ROLL_OVER, onOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
		}
		
	}

}