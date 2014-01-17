package com195z.game.core 
{
	import flash.display.DisplayObject;
	
	/**
	 * 游戏对象 接口
	 * @author wq
	 */
	public interface IGameObject 
	{
		function get isOver():Boolean;
		function get view():DisplayObject;
		function run(passedTime:int):void;
		function dispose():void;
	}
	
}