package com195z.animation 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * 位图动画
	 * 0 为第一帧
	 * @author wq
	 */
	public class BitmapAnimation extends Bitmap implements IAnimation
	{
		private var _dataArray:Vector.<BitmapData>;//图片资源序列
		private var _totalFrames:int;//总帧数
		private var _currentFrame:int;//当前帧
		private var _isPlay:Boolean;//是否播放
		private var _fps:int;//帧频
		private var _frameDuration:int;//帧持续时间
		private var _frameDurationCount:int;//持续时间统计
		
		public function BitmapAnimation(dataArray:Vector.<BitmapData>,fps:int = 12,bitmapData:BitmapData = null,pixelSnapping:String = "auto",smoothing:Boolean = false):void
		{
			super(bitmapData, pixelSnapping, smoothing);
			this.dataArray = dataArray;
			this.fps = fps;
		}
		
		//播放
		public function play():void
		{
			_isPlay = true;
		}
		
		//暂停
		public function stop():void
		{
			_isPlay = false;
		}
		
		//播放控制器
		public function nextFrame(passedTime:int):void
		{
			if (!_isPlay || passedTime <= 0) return;
			_frameDurationCount += passedTime;
			if (_frameDurationCount >= _frameDuration)
			{
				_frameDurationCount -= _frameDuration;
				if (_frameDurationCount > 1000) _frameDurationCount = 0;//阀值
				
				_currentFrame++;
				setFrame(_currentFrame);
			}
			
		}
		
		//帧数范围控制
		private function setFrame(frame:int):void
		{
			if (_dataArray.length > 0)
			{
				if (frame < 0 || frame > (_dataArray.length - 1))
				{
					frame = 0;
				}
				
				_currentFrame = frame;
				bitmapData = _dataArray[_currentFrame]; 
				
			}
			
		}
		
		//从指定帧开始播放
		public function gotoAndPlay(frame:int):void
		{
			setFrame(frame);
			play();
		}
		
		//跳到指定帧并暂停
		public function gotoAndStop(frame:int):void
		{
			setFrame(frame);
			stop();
		}
		
		//属性
		public function get totalFrames():int
		{
			return _totalFrames;
		}
		
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		public function set dataArray(value:Vector.<BitmapData>):void
		{
			_dataArray = value;
			_totalFrames = _dataArray.length;
			_currentFrame = 0;
			_isPlay = true;
			
			setFrame(_currentFrame);
		}
		
		public function set fps(value:int):void
		{
			if (value <= 0) throw new ArgumentError("Invalid fps: " + value);
			_fps = value;
			_frameDuration = Math.round(1000 / _fps);
			_frameDurationCount = 0;
		}
		
		public function get fps():int
		{
			return _fps;
		}
		
	}

}