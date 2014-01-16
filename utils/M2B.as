package com195z.utils 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * MovieClip转BitmapData数组
	 * @author wq
	 */
	public class M2B 
	{
		
		public function M2B():void
		{
			
		}
		
		//MovieClip帧动画转BitmapData数组
		public static function transformM2B(mc:MovieClip):Vector.<BitmapData>
		{
			var result:Vector.<BitmapData> = new Vector.<BitmapData>();
			var bmd:BitmapData;
			
			for (var i:int = 1; i <= mc.totalFrames; i++ )
			{
				mc.gotoAndStop(i);
				
				bmd = new BitmapData(mc.width, mc.height, true, 0);
				bmd.draw(mc);
				
				result.push(bmd);
			}
			
			return result;
		}
		
		/*把组合图片资源拆分为BitmapData数组
		 * @param xml 提供图片资源拆分的数据[x,y,width,height]
		 */
		public static function transformClip(mc:MovieClip, xml:Array):Vector.<BitmapData>
		{
			var result:Vector.<BitmapData> = new Vector.<BitmapData>();
			var bmd:BitmapData;
			mc.stop();
			bmd = new BitmapData(mc.width, mc.height, true, 0);
			bmd.draw(mc);
			
			var clip:BitmapData;
			
			for (var i:int = 0 ; i < xml.length; i++ )
			{
				clip = new BitmapData(xml[i][2], xml[i][3], true, 0);
				clip.copyPixels(bmd, new Rectangle(xml[i][0],xml[i][1], xml[i][2], xml[i][3]), new Point(0, 0));
				
				result.push(clip);
			}
			
			return result;
			
		}
		
	}

}