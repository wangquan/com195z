package com195z.particle 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * 粒子 
	 * @author wq
	 */
	public class Particle extends Bitmap
	{
		private var _scale:Number;//整体缩放值
		
		public var life:int;//存活时间 单位ms
		public var vX:Number;//x,y方向速度
		public var vY:Number;
		
		public function Particle() 
		{
			super();
		}
		
		//属性
		public function set scale(value:Number):void
		{
			_scale = value;
			this.scaleX = this.scaleY = _scale;
		}
		
		public function get scale():Number
		{
			return _scale;
		}
		
		
		//清除数据
		public function dispose():void
		{
			
		}
		
	}

}