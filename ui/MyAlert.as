package com195z.ui 
{
	import com195z.ui.basic.BasicTextField;
	import com195z.ui.basic.BasicWindow;
	import flash.display.BitmapData;
	
	/**
	 * 提示信息
	 * @author wq
	 */
	public class MyAlert extends BasicWindow
	{
		private var _content:BasicTextField;//内容
		private var _confirm:MyButton;//确定按钮
		
		public function MyAlert(background:BitmapData, title:String, upState:BitmapData, text:String = "", overState:BitmapData = null, downState:BitmapData = null, offset:int = 10) 
		{
			super(background, title);
			
			_confirm = new MyButton(upState, text, overState, downState);
			_confirm.x = this.width - _confirm.width >> 1;
			_confirm.y = this.height - _confirm.height - offset;
			_confirm.callback = hid;
			
			_content = new BasicTextField();
			_content.mouseEnabled = false;
			_content.width = this.width - offset;
			_content.height = this.height - this.title.height - _confirm.height - offset * 2;
			_content.x = offset >> 1;
			_content.y = this.title.height + offset;
			
			this.addChild(_content);
			this.addChild(_confirm);
		}
		
		//设置显示文字
		public function setContent(value:String):void
		{
			_content.htmlText = "<center><s16>" + value + "</s16></center>";
		}
		
		
		//清除数据
		override public function dispose():void
		{
			super.dispose();
			
			_content.dispose();
			_confirm.dispose();
		}
		
	}

}