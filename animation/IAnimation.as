package com195z.animation
{
	
	/**
	 * 动画基础接口
	 * @author wq
	 */
	public interface IAnimation
	{
		function play():void;
		function stop():void;
		function nextFrame():void;
		function run(passedTime:int):void;
		function gotoAndPlay(frame:int):void;
		function gotoAndStop(frame:int):void;
		
		function get totalFrames():int;
		function get currentFrame():int;
	}
	
}