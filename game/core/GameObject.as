package com195z.game.core 
{
	import flash.display.DisplayObject;
	
	/**
	 * 游戏对象
	 * @author wq
	 */
	public class GameObject implements IGameObject
	{
		
		public function GameObject() 
		{
			
		}
		
		//主循环
		public function run(passedTime:int):void
		{
			
		}
		
		//属性
		public function get isOver():Boolean
		{
			return false;
		}
		
		public function get view():DisplayObject
		{
			return null;
		}
		
		
		//清除数据
		public function dispose():void
		{
			
		}
		
	}

}