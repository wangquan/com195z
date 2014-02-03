package com195z.ui 
{
	import com195z.ui.basic.BasicContainer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	/**
	 * 进度条 
	 * @author wq
	 */
	public class MyProgressBar extends BasicContainer
	{
		public static const UP:int = 0;
		public static const DOWN:int = 1;
		public static const LEFT:int = 2;
		public static const RIGHT:int = 3;
		
		private var _direction:int;//正方向
		
		private var _back:Bitmap;
		private var _front:Bitmap;
		
		private var _mask:Shape;
		
		public function MyProgressBar(back:BitmapData, front:BitmapData, direction:int = RIGHT) 
		{
			super();
			this.mouseEnabled = false;
			
			_direction = direction;
			
			_back = new Bitmap(back);
			_front = new Bitmap(front);
			
			_mask = new Shape();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0,0,_front.width, _front.height);
			_mask.graphics.endFill();
			switch (_direction)
			{
				case UP:
					_mask.scaleY = -1;
					_mask.y = _front.height;
					break;
				case DOWN:
					break;
				case LEFT:
					_mask.scaleX = -1;
					_mask.x = _front.width;
					break;
				case RIGHT:
					break;
			}
			
			_front.mask = _mask;
			
			this.addChild(_back);
			this.addChild(_front);
			this.addChild(_mask);
		}
		
		//更新进度条
		public function updata(per:Number):void
		{
			if (per < 0) per = 0;
			if (per > 1) per = 1;
			switch (_direction)
			{
				case UP:
					_mask.scaleY = -per;
					break;
				case DOWN:
					_mask.scaleY = per;
					break;
				case LEFT:
					_mask.scaleX = -per;
					break;
				case RIGHT:
					_mask.scaleX = per;
					break;
			}
		}
		
		//清除数据
		override public function dispose():void
		{
			super.dispose();
			
		}
		
	}

}