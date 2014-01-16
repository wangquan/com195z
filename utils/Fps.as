package com195z.utils 
{
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.system.System;
	
	/**
	 * 帧数 和 内存统计
	 * @author wq
	 */
	public class Fps extends TextField
	{
		private var _fps:int;//计数器
		private var _timer:Timer;//计时器
		
		public function Fps():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			_fps = 0;
			mouseEnabled = false;
			width = 100;
			height = 40;
			background = true;
			backgroundColor = 0x000000;
			border = true;
			borderColor = 0xffea00;
			textColor = 0xffffff;
			wordWrap = true;
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void
		{
			_fps++;
		}
		
		private function onTimer(e:TimerEvent):void
		{
			text = "FPS:" + _fps + "\n Memory:" + Math.round(System.totalMemory/1048576) + "MB";
			_fps = 0;
		}
		
		
		//清除数据
		public function dispose():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onFrame);
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
		}
		
	}

}