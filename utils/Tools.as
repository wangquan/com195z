package com195z.utils 
{
	/**
	 * 数学工具
	 * @author wq
	 */
	public class Tools 
	{
		
		public function Tools() 
		{
			
		}
		
		//返回 范围内随机的一个整数（包含）
		public static function rand(start:int = 0, end:int = 100):int
		{
			end = end - start;
			return start + Math.round(Math.random() * end);
		}
		
		//随机返回 1 或 -1
		public static function getPoN():int
		{
			return Math.random() > 0.5 ? -1: 1;
		}
		
	}

}