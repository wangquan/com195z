package com195z.utils 
{
	
	/**
	 * 碰撞检测
	 * @author wq
	 */
	public class Collision 
	{
		//临时变量
		private static var _dX:Number;
		private static var _dY:Number;
		private static var _distance:Number;
		private static var _minDis:Number;
		
		public function Collision() 
		{
			
		}
		
		//点对矩形 
		public static function pointToRect(pX:Number, pY:Number, rX:Number, rY:Number, rWidth:Number, rHeight:Number):Boolean
		{
			if (pX > rX && pX < (rX + rWidth) && pY > rY && pY < (rY + rHeight))
			{
				return true;
			}
			return false;
		}
		
		//点对圆
		public static function pointToCircle(pX:Number, pY:Number, cX:Number, cY:Number, radius:Number):Boolean
		{
			_dX = pX - cX;
			_dY = pY - cY;
			_distance = Math.sqrt(_dX * _dX + _dY * _dY);
			if (_distance < radius) return true;
			return false;
		}
		
		//矩形对矩形
		public static function rectToRect(x:Number, y:Number, width:Number, height:Number, rX:Number, rY:Number, rWidth:Number, rHeight:Number):Boolean
		{
			if (x + width > rX && x < rX + rWidth && y + height > rY && y < rY + rHeight)
			{
				return true;
			}
			return false;
		}
		
		//矩形对圆形
		public static function rectToCircle(rX:Number, rY:Number, rWidth:Number, rHeight:Number, cX:Number, cY:Number, radius:Number):Boolean
		{
			if (pointToCircle(rX, rY, cX, cY, radius))
			{
				return true;
			} else if (pointToCircle(rX + rWidth, rY, cX, cY, radius))
			{
				return true;
			} else if (pointToCircle(rX + rWidth, rY + rHeight, cX, cY, radius))
			{
				return true;
			} else if (pointToCircle(rX, rY + rHeight, cX, cY, radius))
			{
				return true;
			}
			
			if (cY > rY && cY < rY + rHeight)
			{
				if (cX < rX)
				{
					_minDis = rX - cX;
				}else if (cX > rX + rWidth)
				{
					_minDis = cX - rX - rWidth;
				}else
				{
					return true;
				}
				
				if ( _minDis < radius) return true;
			}
			
			if (cX > rX && cX < rX + rWidth)
			{
				if (cY < rY)
				{
					_minDis = rY - cY;
				}else if (cY > rY + rHeight)
				{
					_minDis = cY - rY - rHeight;
				}else
				{
					return true;
				}
				if (_minDis < radius) return true;
			}
			
			return false;
		}
		
		//圆对圆
		public static function circleToCircle(x:Number, y:Number, radius:Number, cX:Number, cY:Number, cRadius:Number):Boolean
		{
			_dX = x - cX;
			_dY = y - cY;
			_distance = Math.sqrt(_dX * _dX + _dY * _dY);
			if (_distance < (radius + cRadius)) return true;
			return false;
		}
		
		
	}

}