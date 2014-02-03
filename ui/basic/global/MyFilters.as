package com195z.ui.basic.global 
{
	import flash.filters.GlowFilter;
	
	/**
	 * 全局 通用滤镜
	 * @author wq
	 */
	public class MyFilters
	{
		public static const BLACK_GLOW:Array = [new GlowFilter(0x000000, 1, 2, 2, 16)];
		public static const WHITE_GLOW:Array = [new GlowFilter(0xffffff, 1, 2, 2, 16)];
		
		public function MyFilters() 
		{
			
		}
		
	}

}