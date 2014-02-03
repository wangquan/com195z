package com195z.ui.basic 
{
	import com195z.ui.basic.global.MyStyleSheet;
	import flash.text.TextField;
	
	/**
	 * 基础文字
	 * @author wq
	 */
	public class BasicTextField extends TextField implements IBasicUI
	{
		
		public function BasicTextField() 
		{
			super();
			this.styleSheet = MyStyleSheet.manager().styleSheet;
			this.wordWrap = true;
		}
		
		//清除数据
		public function dispose():void
		{
			if (this.parent != null)
			{
				this.parent.removeChild(this);
			}
		}
		
	}

}