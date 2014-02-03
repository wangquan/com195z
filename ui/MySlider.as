package com195z.ui 
{
	import com195z.ui.basic.BasicContainer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 滑动条
	 * @author wq
	 */
	public class MySlider extends BasicContainer
	{
		private var _direction:int;//滑块移动方向
		
		private var _bar:Bitmap;
		private var _slider:SliderBox;
		
		private var _maxLength:int;
		private var _isSlider:Boolean;
		
		private var _offsetX:int;
		private var _offsetY:int;
		
		private var _per:Number;//移动比率 0-1
		
		public function MySlider(bar:BitmapData, upState:BitmapData, overState:BitmapData = null, downState:BitmapData = null, direction:int = 0) 
		{
			super();
			this.mouseChildren = true;
			
			_direction = direction;
			
			_bar = new Bitmap(bar);
			_slider = new SliderBox(upState, overState, downState);
			
			if (_direction == SliderBox.HORIZONTAL)
			{
				_maxLength = _bar.width - _slider.width;
			}else
			{
				_maxLength = _bar.height - _slider.height;
			}
			_isSlider = false;
			
			_offsetX = 0;
			_offsetY = 0;
			
			_per = 0.0;
			
			this.addChild(_bar);
			this.addChild(_slider);
			
			_slider.addEventListener(MouseEvent.MOUSE_DOWN, onSliderDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
			this.addEventListener(MouseEvent.ROLL_OUT, onUp);
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void
		{
			if (_isSlider)
			{
				if (_direction == SliderBox.HORIZONTAL)
				{
					_slider.x = mouseX - _offsetX;
					_slider.y = 0;
					if (_slider.x < 0) _slider.x = 0;
					if (_slider.x > _maxLength) _slider.x = _maxLength;
					
					_per = _slider.x / _maxLength;
				}else
				{
					_slider.x = 0;
					_slider.y = mouseY - _offsetY;
					if (_slider.y < 0) _slider.y = 0;
					if (_slider.y > _maxLength) _slider.y = _maxLength;
					_per = _slider.y / _maxLength;
				}
			}
		}
		
		private function onSliderDown(e:MouseEvent):void
		{
			_isSlider = true;
			_offsetX = e.localX;
			_offsetY = e.localY;
		}
		
		private function onUp(e:MouseEvent):void
		{
			_isSlider = false;
		}
		
		//属性
		public function get per():Number
		{
			return _per;
		}
		
		//清除数据
		override public function dispose():void
		{
			super.dispose();
			_slider.removeEventListener(MouseEvent.MOUSE_DOWN, onSliderDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			this.removeEventListener(MouseEvent.ROLL_OUT, onUp);
			this.removeEventListener(Event.ENTER_FRAME, onFrame);
			
			_slider.dispose();
		}
		
	}

}