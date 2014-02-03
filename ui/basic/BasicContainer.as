package com195z.ui.basic 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	/**
	 * 基础容器
	 * @author wq
	 */
	public class BasicContainer extends Sprite implements IBasicUI
	{
		
		public function BasicContainer() 
		{
			this.mouseChildren = false;
			this.tabChildren = false;
			this.tabEnabled = false;
		}
		
		//显示 隐藏
		public function show(container:DisplayObjectContainer):void
		{
			container.addChild(this);
		}
		
		public function hid():void
		{
			if (this.parent != null)
			{
				this.parent.removeChild(this);
			}
		}
		
		//清除数据
		public function dispose():void
		{
			hid();
		}
		
	}

}