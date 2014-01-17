package com195z.asset 
{
	/**
	 * 资源库 单例模式
	 * @author wq
	 */
	public class AssetLibrary 
	{
		private static var _assetLibrary:AssetLibrary;
		
		private var _pool:Object;//资源池
		
		public function AssetLibrary(key:AssetLibraryKey) 
		{
			if (key == null) throw new Error("Singleton!");
			_pool = new Object();
		}
		
		//取得资源管理
		public static function manager():AssetLibrary
		{
			if (_assetLibrary == null) _assetLibrary = new AssetLibrary(new AssetLibraryKey());
			return _assetLibrary;
		}
		
		//添加一个资源
		public function addAsset(name:String, data:*):void
		{
			_pool[name] = data;
		}
		
		//取一个资源
		public function getAsset(name:String):*
		{
			return _pool[name];
		}
		
		//移除一个资源
		public function removeAsset(name:String):void
		{
			_pool[name] = null;
		}
		
		
		//清除数据
		public function dispose():void
		{
			_assetLibrary = null;
		}
		
	}

}

class AssetLibraryKey
{
	
}