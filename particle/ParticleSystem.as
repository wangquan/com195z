package com195z.particle 
{
	import com195z.utils.GameTimer;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 * 粒子系统 基于cpu
	 * @author wq
	 */
	public class ParticleSystem 
	{
		public static var MaxNumber:int = 100;//粒子系统最大粒子数
		public static var PoolNumber:int = 100;//池初始化数量
		private static var _particlePool:Vector.<Particle>;//粒子池 
		
		private var _container:DisplayObjectContainer;//粒子容器
		private var _bitmapData:BitmapData;//图像资源
		private var _particles:Vector.<Particle>;//粒子
		private var _format:ParticleSystemFormat;//粒子系统设计
		
		private var _timeCount:int;//时间统计
		
		private var _isStop:Boolean;
		private var _gameTimer:GameTimer;
		
		//临时变量
		private var _tempParticle:Particle;
		private var _tempAngle:Number;
		private var _tempSpeed:Number;
		private var _tempNum:int;
		
		public function ParticleSystem(bitmapData:BitmapData, container:DisplayObjectContainer, format:ParticleSystemFormat = null) 
		{
			//初始化粒子池
			if (_particlePool == null)
			{
				_particlePool = new Vector.<Particle>();
				for (var i:int = 0; i < PoolNumber; i++)
				{
					_particlePool.push(new Particle());
				}
			}
			_particles = new Vector.<Particle>();
			_container = container;
			_bitmapData = bitmapData;
			if (format == null) format = new ParticleSystemFormat();
			_format = format;
			
			_timeCount = 0;
			
			_isStop = true;
			_gameTimer = new GameTimer();
			
			_container.addEventListener(Event.ENTER_FRAME, onFrame);
			
		}
		
		//帧循环
		private function onFrame(e:Event):void
		{
			_gameTimer.tick();
			
			if (!_isStop)
			{
				buildParticle(_gameTimer.passedTime);
			}
			runParticle(_gameTimer.passedTime);
			
		}
		
		//产生粒子机制
		private function buildParticle(passedTime:int):void
		{
			_timeCount += passedTime;
			if (_timeCount >= _format.buildTime)
			{
				_tempNum = _timeCount / _format.buildTime;
				if (_tempNum > 10) _tempNum = 10;//阀值
				_timeCount = 0;
				while (_tempNum > 0)
				{
					_tempNum--;
					addOneParticle();
				}
			}
		}
		
		//添加一个粒子
		private function addOneParticle():void
		{
			if (_particles.length < MaxNumber)
			{
				_tempParticle = borrowParticle();//借
				_tempParticle.bitmapData = _bitmapData;
				_tempParticle.life = _format.life;
				_tempParticle.x = _format.x + Math.random() * _format.startVarX;
				_tempParticle.y = _format.y + Math.random() * _format.startVarY;
				
				_tempParticle.scale = _format.startScale + Math.random() * _format.startVarScale;
				
				_tempAngle = _format.emitterAngle + Math.random() * _format.emitterVarAngle;
				
				_tempParticle.rotation = _format.startRot + Math.random() * _format.startVarRot;
				
				_tempParticle.alpha = _format.startAlpha + Math.random() * _format.startVarAlpha;
				
				_tempSpeed = _format.startSpeed + Math.random() * _format.startVarSpeed;
				
				_tempParticle.vX = Math.cos(_tempAngle * (Math.PI / 180)) * _tempSpeed;
				_tempParticle.vY = Math.sin(_tempAngle * (Math.PI / 180)) * _tempSpeed;
				
				_particles.push(_tempParticle);
				_container.addChild(_tempParticle);
			}
		}
		
		//运行粒子机制
		private function runParticle(passedTime:int):void
		{
			for (var i:int = 0; i < _particles.length; i++)
			{
				if (_particles[i].life <= 0 || _particles[i].alpha <= 0  || _particles[i].scale == 0)
				{
					//结束粒子
					_container.removeChild(_particles[i]);
					returnParticle(_particles.splice(i, 1)[0]);//还
					i--;
					continue;
				}
				
				//运行粒子
				_tempParticle = _particles[i];
				
				_tempParticle.life -= passedTime;
				if (_format.vAlpha != 0)_tempParticle.alpha -= _format.vAlpha;
				if (_format.vScale != 0)_tempParticle.scale -= _format.vScale;
				_tempParticle.vX += _format.gravityX;
				_tempParticle.vY += _format.gravityY;
				
				if (_format.vScale != 0) _tempParticle.scale += _format.vScale;
				
				_tempParticle.x += _tempParticle.vX;
				_tempParticle.y += _tempParticle.vY;
				
			}
		}
		
		//粒子池取、还粒子
		private function borrowParticle():Particle
		{
			if (_particlePool.length > 0) return _particlePool.shift();
			return new Particle();
		}
		
		private function returnParticle(value:Particle):void
		{
			_particlePool.push(value);
		}
		
		//启动
		public function start():void
		{
			_isStop = false;
		}
		
		//暂停
		public function stop():void
		{
			_isStop = true;
		}
		
		//清除粒子池
		public static function clearPool():void
		{
			_particlePool = null;
		}
		
		//属性
		public function get isStop():Boolean
		{
			return _isStop;
		}
		
		public function get format():ParticleSystemFormat
		{
			return _format;
		}
		
		
		
		//清除数据
		public function dispose():void
		{
			_container.removeEventListener(Event.ENTER_FRAME, onFrame);
			
			for (var i:int = 0; i < _particles.length; i++)
			{
				_container.removeChild(_particles[i]);
				returnParticle(_particles.splice(i, 1)[0]);//还
				i--;
				continue;
			}
			
			_container = null;
			_bitmapData = null;
			_particles = null;
			_format = null;
			
			_gameTimer = null;
			
			_tempParticle = null;
			
		}
		
	}

}