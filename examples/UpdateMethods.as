package
{
	import com.somerandomdude.coordy.constants.LayoutUpdateMode;
	import com.somerandomdude.coordy.helpers.SimpleZSorter;
	import com.somerandomdude.coordy.layouts.threedee.Ellipse3d;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	public class UpdateMethods extends Sprite
	{
		private var _ellipse3d:Ellipse3d;
		private var _size:int;
		private var _caption:Text;
		private var _updateLabel:Label;
		
		public function UpdateMethods()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			init();
		}
		
		private function init():void
		{
			_size=100;
			/* 
			* For explanations on basic setup and adding items to the layout, refer to the
			* 'AddChildren' and/or 'AddToLayout' example clases.
			*/
			_ellipse3d = new Ellipse3d(this, 360, 360, 200, 200, 0, 0, 1);
			_ellipse3d.updateMethod=LayoutUpdateMode.NONE;

			var s:Square;
			for(var i:int=0; i<_size; i++)
			{
				s = new Square();
				_ellipse3d.addToLayout(s, false);
				addChild(s);
			}
			
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
			
			_caption = new Text();
			_caption.text='A basic example of tweening a layout\'s properties. Click anywhere to tween the layout randomly';
			_caption.y=400;
			addChild(_caption);
			
			_updateLabel = new Label();
			addChild(_updateLabel);
			
			updateAndRender();
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			var rand:Number=Math.round(Math.random()*3);
			switch(rand)
			{
				case 0:
					updateAndRender();
					break;
				case 1:
					updateOnly();
					break;
				default:
					manualUpdate();
			}
			
		}
		
		private function updateAndRender():void
		{
			/*
			* This example manages the updating rendering and z-sorting automatically - which makes
			* it the simplest and most convenient method for updating a layout. It is, unfortunately,
			* also the least efficient method since the update/render/z-sort cycle is run for each
			* property change.
			*/
			_updateLabel.text='Updated with LayoutUpdateMode.UPDATE_AND_RENDER and auto Z-Sorting';
			
			var x:Number=Math.random()*50+175;
			var y:Number=Math.random()*50+175;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var rotationX:Number=Math.random()*360;
			var rotationY:Number=Math.random()*360;
			var rotationZ:Number=Math.random()*360;
			
			_ellipse3d.updateMethod=LayoutUpdateMode.UPDATE_AND_RENDER;
			_ellipse3d.autoZSort=true;
			
			_ellipse3d.x=x;
			_ellipse3d.y=y;
			_ellipse3d.width=width;
			_ellipse3d.depth=depth;
			_ellipse3d.rotationX=rotationX;
			_ellipse3d.rotationY=rotationY;
			_ellipse3d.rotationZ=rotationZ;			
		}
		
		private function updateOnly():void
		{
			/*
			* This example manages the only the updating of the layout automatically - rendering the
			* DisplayObjects and Z-Sorting them are done manually. It is much more efficient than the
			* fully automated approach, but there is still unnecessary CPU usage. 
			*/
			_updateLabel.text='Updated with LayoutUpdateMode.UPDATE_ONLY and manual Z-Sorting';
			
			var x:Number=Math.random()*50+175;
			var y:Number=Math.random()*50+175;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var rotationX:Number=Math.random()*360;
			var rotationY:Number=Math.random()*360;
			var rotationZ:Number=Math.random()*360;
			
			_ellipse3d.updateMethod=LayoutUpdateMode.UPDATE_ONLY;
			_ellipse3d.autoZSort=true;
			
			_ellipse3d.x=x;
			_ellipse3d.y=y;
			_ellipse3d.width=width;
			_ellipse3d.depth=depth;
			_ellipse3d.rotationX=rotationX;
			_ellipse3d.rotationY=rotationY;
			_ellipse3d.rotationZ=rotationZ;
			
			_ellipse3d.render();
			
			SimpleZSorter.sortLayout(_ellipse3d);
		}
		
		private function manualUpdate():void
		{
			/*
			* This example performs all cycles (layout updating, node rendering and z-sorting) only 
			* once - after all properties have been altered. This is by far the most efficient approach
			* to changing a layout, especially if tweening the layout.
			*/
			_updateLabel.text='Updated with LayoutUpdateMode.NONE and manual Z-Sorting';
			
			var x:Number=Math.random()*50+175;
			var y:Number=Math.random()*50+175;
			var width:Number=200+Math.random()*200;
			var height:Number=200+Math.random()*200;
			var depth:Number=200+Math.random()*200;
			var rotationX:Number=Math.random()*360;
			var rotationY:Number=Math.random()*360;
			var rotationZ:Number=Math.random()*360;
			
			_ellipse3d.updateMethod=LayoutUpdateMode.NONE;
			_ellipse3d.autoZSort=false;
			
			_ellipse3d.x=x;
			_ellipse3d.y=y;
			_ellipse3d.width=width;
			_ellipse3d.depth=depth;
			_ellipse3d.rotationX=rotationX;
			_ellipse3d.rotationY=rotationY;
			_ellipse3d.rotationZ=rotationZ;
			
			_ellipse3d.updateAndRender();
			SimpleZSorter.sortLayout(_ellipse3d);
		}
		
	}
}

import flash.display.Shape;
import flash.text.TextField;
import flash.text.engine.Kerning;
import flash.text.AntiAliasType;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;

internal class Square extends Shape
{
	public function Square():void
	{
		graphics.lineStyle(1);
		graphics.beginFill(0xffffff, .7);
		graphics.drawRect(-10, -10, 20, 20);
		graphics.endFill();
	}
}

internal class Text extends TextField
{
	protected var _format:TextFormat;
	
	public function Text()
	{
		_format = new TextFormat();
		_format.font='Arial';
		_format.size=11;
		_format.kerning=Kerning.ON;
	
		textColor=0x333333;
		antiAliasType=AntiAliasType.ADVANCED;
		wordWrap=true;
		multiline=true;
		autoSize=TextFieldAutoSize.LEFT;
		width=400;
		defaultTextFormat=_format;
	}
}

internal class Label extends Text
{
	public function Label()
	{
		super();
		_format.size=13;
		textColor=0x000000;
	}
}