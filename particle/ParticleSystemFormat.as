package com195z.particle 
{
	/**
	 * 粒子系统设置
	 * @author wq
	 */
	public class ParticleSystemFormat 
	{
		private var _life:int;//生命(存活)时间 单位ms
		
		public var x:Number;//发射起始位置
		public var y:Number;
		public var startVarX:Number;//x,y起始位置偏移
		public var startVarY:Number;
		
		private var _numParticle:int;//1000ms时间内产生的粒子数
		private var _buildTime:int;//产生一个粒子的时间
		
		public var startScale:Number;//起始大小
		public var startVarScale:Number;//起始大小变化范围
		public var vScale:Number;//大小变值
		
		public var emitterAngle:Number;//发射角度
		public var emitterVarAngle:Number;//角度变化范围
		
		public var startRot:Number;//发射图片旋转
		public var startVarRot:Number;//发射图片旋转变化范围
		
		public var startAlpha:Number;//起始透明度
		public var startVarAlpha:Number;//起始变化范围
		private var _vAlpha:Number;//透明度变值
		
		public var startSpeed:Number;//发射速度
		public var startVarSpeed:Number;//速度变化范围
		public var gravityX:Number;//x,y方向阻力
		public var gravityY:Number;
		
		
		public function ParticleSystemFormat() 
		{
			//初始化 默认值
			life = 8000;
			
			x = 0;
			y = 0;
			startVarX = 0;
			startVarY = 0;
			
			numParticle = 10;
			
			startScale = 0.4;
			startVarScale = 0.6;
			vScale = 0;
			
			emitterAngle = 0;
			emitterVarAngle = 0;
			
			startRot = 0;
			startVarRot = 0;
			
			startAlpha = 1;
			startVarAlpha = 0;
			vAlpha = 0.02;
			
			startSpeed = 2;
			startVarSpeed = 6;
			gravityX = 0;
			gravityY = 0;
			
		}
		
		//属性
		public function get life():int
		{
			return _life;
		}
		
		public function set life(value:int):void
		{
			_life = value;
		}
		
		public function get numParticle():int
		{
			return _numParticle;
		}
		
		public function set numParticle(value:int):void
		{
			if (value > 1000) value = 1000;
			if (value <= 0) value = 1;
			_numParticle = value;
			_buildTime = Math.round(1000 / _numParticle);
		}
		
		public function get buildTime():int
		{
			return _buildTime;
		}
		
		public function get vAlpha():Number
		{
			return _vAlpha;
		}
		
		public function set vAlpha(value:Number):void
		{
			_vAlpha =  value;
		}
		
	}

}