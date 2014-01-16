package com195z.sound 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	
	/**
	 * 声音管理 单例模式
	 * @author wq
	 */
	public class SoundManager 
	{
		private static var _soundManager:SoundManager;
		
		private var _pool:Object;//声音池
		
		private var _musicSoundChannel:SoundChannel;//背景音乐声道
		private var _effectSoundChannel:Vector.<SoundChannel>;//特效声道
		//声音控制
		private var _musicSoundTransform:SoundTransform;
		private var _effectSoundTransform:SoundTransform;
		//音量
		private var _musicVolume:Number;
		private var _effectVolume:Number;
		private var _defaultMusicVolume:Number = 0.5;
		private var _defaultEffectVolume:Number = 0.5;
		//地址 前缀
		private var _musicURL:String = "res/sound/music/";
		private var _effectURL:String = "res/sound/effect/";
		
		//需要重复播放的背景音乐
		private var _music:Sound;
		//循环背景音的间隔时间
		private var _timer:Timer;
		
		
		public function SoundManager(key:SoundManagerKey) 
		{
			if (key == null) throw new Error("Singleton!");
			_pool = new Object();
			
			_musicSoundChannel = new SoundChannel();
			_effectSoundChannel = new Vector.<SoundChannel>();
			
			_musicVolume = _defaultMusicVolume;
			_effectVolume = _defaultEffectVolume;
			
			_musicSoundTransform = new SoundTransform(_musicVolume);
			_effectSoundTransform = new SoundTransform(_effectVolume);
			
			_timer = new Timer(10000,1);
		}
		
		//取得音乐管理
		public static function manager():SoundManager
		{
			if (_soundManager == null) _soundManager = new SoundManager(new SoundManagerKey());
			return _soundManager;
		}
		
		//播放音乐
		public function playMusic(name:String):void
		{
			//没有关闭音乐
			if (_musicVolume != 0)
			{
				if (_pool[name] == null)
				{
					var mySound:MySound = new MySound();
					mySound.name = name;
					mySound.addEventListener(Event.COMPLETE, onComplete);
					mySound.addEventListener(IOErrorEvent.IO_ERROR, onError);
					mySound.load(new URLRequest(_musicURL + name));
					_pool[name] = mySound;
				}
				clearMusic();
				_music = _pool[name] as Sound;
				_musicSoundChannel = _music.play();
				_musicSoundChannel.soundTransform = _musicSoundTransform;
				_musicSoundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			}
		}
		
		//背景音乐播放完毕
		private function onMusicComplete(e:Event):void
		{
			_musicSoundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			if (_musicVolume != 0)
			{
				_timer.reset();
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
				_timer.start();
			}
			
			trace("音乐完毕");
		}
		
		//音乐间隔完毕
		private function onTimerComplete(e:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			if (_musicVolume != 0)
			{
				if (_music != null)
				{
					_musicSoundChannel.stop();
					_musicSoundChannel = _music.play();
					_musicSoundChannel.soundTransform = _musicSoundTransform;
					_musicSoundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
				}
			}
			
			trace("音乐再播放一次");
		}
		
		//播放音效
		public function playEffect(name:String):void
		{
			//没有关闭音效
			if (_effectVolume != 0)
			{
				if (_pool[name] == null)
				{
					var mySound:MySound = new MySound();
					mySound.name = name;
					mySound.addEventListener(Event.COMPLETE, onComplete);
					mySound.addEventListener(IOErrorEvent.IO_ERROR, onError);
					mySound.load(new URLRequest(_effectURL + name));
					_pool[name] = mySound;
				}
				//超过5个音效 关闭一个
				if (_effectSoundChannel.length > 5)
				{
					_effectSoundChannel.shift().stop();
				}
				var newChannel:SoundChannel = (_pool[name] as Sound).play();
				newChannel.soundTransform = _effectSoundTransform;
				_effectSoundChannel.push(newChannel);
				//依次减低前面的声音
				for (var i:int = 0; i < _effectSoundChannel.length; i++)
				{
					_effectSoundChannel[i].soundTransform.volume = _effectVolume * ((i + 1) / _effectSoundChannel.length);
				}
				
			}
		}
		
		//音乐开关
		public function openMusic():void
		{
			_musicVolume = _defaultMusicVolume;
			_musicSoundTransform.volume = _musicVolume;
			if (_music != null)
			{
				_musicSoundChannel = _music.play();
				_musicSoundChannel.soundTransform = _musicSoundTransform;
				_musicSoundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			}
		}
		
		public function closeMusic():void
		{
			_musicVolume = 0;
			_musicSoundChannel.stop();
			if (_musicSoundChannel.hasEventListener(Event.SOUND_COMPLETE))
			{
				_musicSoundChannel.removeEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			}
			_timer.stop();
			if (_timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			}
		}
		
		//音效开关
		public function openEffect():void
		{
			_effectVolume = _defaultEffectVolume;
			_effectSoundTransform.volume = _effectVolume;
		}
		
		public function closeEffect():void
		{
			_effectVolume = 0;
			clearEffect();
		}
		
		//清除音乐
		public function clearMusic():void
		{
			_music = null;
			_musicSoundChannel.stop();
			if (_musicSoundChannel.hasEventListener(Event.SOUND_COMPLETE))
			{
				_musicSoundChannel.removeEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			}
			_timer.stop();
			if (_timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			}
		}
		
		//清除音效
		public function clearEffect():void
		{
			for each(var channel:SoundChannel in _effectSoundChannel)
			{
				channel.stop();
			}
		}
		
		//加载完毕
		private function onComplete(e:Event):void
		{
			var mySound:MySound = e.target as MySound;
			mySound.removeEventListener(Event.COMPLETE, onComplete);
			mySound.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			
			trace(mySound.name + "加载完成");
		}
		
		//加载错误
		private function onError(e:IOErrorEvent):void
		{
			var mySound:MySound = e.target as MySound;
			mySound.removeEventListener(Event.COMPLETE, onComplete);
			mySound.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			_pool[mySound.name] = null;
			
			trace(mySound.name + "加载失败");
		}
		
		//添加音乐 音效资源
		public function addSound(name:String, sound:Sound):void
		{
			_pool[name] = sound;
		}
		
		//移除音乐 音效资源
		public function removeSound(name:String):void
		{
			_pool[name] = null;
		}
		
		
		
		//属性
		public function set musicVolume(value:Number):void
		{
			if (value < 0) value = 0;
			if (value > 1) value = 1;
			_musicVolume = value;
			if (_musicVolume == 0)
			{
				closeMusic();
			}else
			{
				_musicSoundTransform.volume = _musicVolume;
				_musicSoundChannel.soundTransform = _musicSoundTransform;
			}
			
		}
		
		public function get musicVolume():Number
		{
			return _musicVolume;
		}
		
		public function set effectVolume(value:Number):void
		{
			if (value < 0) value = 0;
			if (value > 1) value = 1;
			_effectVolume = value;
			if (_effectVolume == 0)
			{
				closeEffect();
			}else
			{
				_effectSoundTransform.volume = _effectVolume;
			}
		}
		
		public function get effectVolume():Number
		{
			return _effectVolume;
		}
		
		
		
		
		
		
		
		//清除数据
		public function dispose():void
		{
			clearMusic();
			clearEffect();
			
			_soundManager = null;
		}
		
	}

}

class SoundManagerKey
{
	
}