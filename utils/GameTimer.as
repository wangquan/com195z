package com195z.utils 
{
	import flash.utils.getTimer;
	
	/**
	 * 游戏计时器 心跳机 单位ms
	 * @author wq
	 */
	public class GameTimer 
	{	
		private var _lastFrameTime:int;//上一帧时间
		private var _currentFrameTime:int;//当前帧时间
		private var _passedTime:int;//上帧到现在经过的时间
		
		private var _totalTime:int;//心跳运行总时间
		private var _lastHeartBeatTime:int;//上一次心跳时间
		private var _intervalTime:uint;//心跳间隔时间
		
		private var _callback:Function;//回调函数
		
		public function GameTimer(callback:Function = null, intervalTime:uint = 1000) 
		{
			_lastFrameTime = 0;
			_currentFrameTime = 0;
			_passedTime = 0;
			
			_callback = callback;
			_totalTime = _lastHeartBeatTime = 0;
			_intervalTime = intervalTime;
		}
		
		//时间标记
		public function tick():void
		{
			_currentFrameTime = getTimer();
			if (_lastFrameTime == 0)
			{
				_lastFrameTime = _currentFrameTime;
				return;
			}
			_passedTime = _currentFrameTime - _lastFrameTime;
			_lastFrameTime = _currentFrameTime;
		}
		
		//心跳机 
		public function heartBeat(passedTime:int):void
		{
			if (_callback != null)
			{
				_totalTime += passedTime;
				if (_totalTime - _lastHeartBeatTime >= _intervalTime)
				{
					_callback();
					_lastHeartBeatTime += _intervalTime;
				}
			}
		}
		
		
		//属性
		public function get passedTime():int
		{
			return _passedTime;
		}
		
		public function get totalTime():int
		{
			return _totalTime;
		}
		
		public function set intervalTime(value:uint):void
		{
			_intervalTime = value;
		}
		
		public function get intervalTime():uint
		{
			return _intervalTime;
		}
		
		public function set callback(value:Function):void
		{
			_callback = value;
		}
		
		public function get callback():Function
		{
			return _callback;
		}
		
		
	}

}