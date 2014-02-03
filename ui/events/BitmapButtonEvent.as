package com195z.ui.events 
{
	import flash.events.Event;
	
	/**
	 * 位图按钮事件
	 * @author wq
	 */
	public class BitmapButtonEvent extends Event
	{
		public static const CLICK:String = "click";
		public static const DOWN:String = "down";
		public static const UP:String = "up";
		public static const OVER:String = "over";
		public static const OUT:String = "out";
		
		public function BitmapButtonEvent(type:String, bubbles:Boolean = false, canelable:Boolean = true)
		{
			super(type, bubbles, cancelable);
		}
		
	}

}