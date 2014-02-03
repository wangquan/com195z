package com195z.ui 
{
	import com195z.ui.basic.BasicContainer;
	import com195z.ui.events.BitmapButtonEvent;
	import com195z.utils.Collision;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	/**
	 * 位图按钮 容器
	 * @author wq
	 */
	public class MyBitmapButtonContainer extends BasicContainer
	{
		private var _buttons:Vector.<MyBitmapButton>;//按钮组
		
		private var _isMove:Boolean;
		
		public function MyBitmapButtonContainer() 
		{
			super();
			this.buttonMode = true;
			
			_buttons = new Vector.<MyBitmapButton>();
			
			_isMove = false;
			
			this.addEventListener(Event.ENTER_FRAME, onFrame);
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		//主循环
		private function onFrame(e:Event):void
		{
			if (_isMove)
			{
				_isMove = false;
				for each(var bt:MyBitmapButton in _buttons)
				{
					if (Collision.pointToRect(mouseX, mouseY, bt.x, bt.y, bt.width, bt.height))
					{
						if (bt.state == MyBitmapButton.UP)
						{
							var over:BitmapButtonEvent = new BitmapButtonEvent(BitmapButtonEvent.OVER);
							bt.dispatchEvent(over);
						}
					}else if (bt.state != MyBitmapButton.UP)
					{
						var out:BitmapButtonEvent = new BitmapButtonEvent(BitmapButtonEvent.OUT);
						bt.dispatchEvent(out);
					}
				}
			}
		}
		
		//鼠标事件
		private function onClick(e:MouseEvent):void
		{
			for each(var bt:MyBitmapButton in _buttons)
			{
				if (Collision.pointToRect(e.localX, e.localY, bt.x, bt.y, bt.width, bt.height))
				{
					var click:BitmapButtonEvent = new BitmapButtonEvent(BitmapButtonEvent.CLICK);
					bt.dispatchEvent(click);
					break;
				}
			}
		}
		
		private function onOut(e:MouseEvent):void
		{
			for each(var bt:MyBitmapButton in _buttons)
			{
				if (bt.state != MyBitmapButton.UP)
				{
					var out:BitmapButtonEvent = new BitmapButtonEvent(BitmapButtonEvent.OUT);
					bt.dispatchEvent(out);
				}
			}
		}
		
		private function onDown(e:MouseEvent):void
		{
			for each(var bt:MyBitmapButton in _buttons)
			{
				if (Collision.pointToRect(e.localX, e.localY, bt.x, bt.y, bt.width, bt.height))
				{
					var down:BitmapButtonEvent = new BitmapButtonEvent(BitmapButtonEvent.DOWN);
					bt.dispatchEvent(down);
					break;
				}
			}
		}
		
		private function onUp(e:MouseEvent):void
		{
			for each(var bt:MyBitmapButton in _buttons)
			{
				if (Collision.pointToRect(e.localX, e.localY, bt.x, bt.y, bt.width, bt.height))
				{
					var up:BitmapButtonEvent = new BitmapButtonEvent(BitmapButtonEvent.UP);
					bt.dispatchEvent(up);
					break;
				}
			}
		}
		
		private function onMove(e:MouseEvent):void
		{
			_isMove = true;
		}
		
		//添加
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (child is MyBitmapButton)_buttons.push(child);
			return super.addChild(child);
		}
		
		//移除
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			if (child is MyBitmapButton)
			{
				for (var i:int = 0; i < _buttons.length; i++)
				{
					if (_buttons[i] === child)
					{
						_buttons.splice(i,1);
						break;
					}
				}
			}
			return super.removeChild(child);
		}
		
		
		//清除数据
		override public function dispose():void
		{
			super.dispose();
			this.removeEventListener(Event.ENTER_FRAME, onFrame);
			this.removeEventListener(MouseEvent.CLICK, onClick);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			
		}
		
	}

}