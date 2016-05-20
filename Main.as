﻿package {	import flash.display.MovieClip;	import flash.display.DisplayObject;	import flash.text.TextFormat;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import fl.motion.Color;	import fl.controls.CheckBox;	import flash.events.MouseEvent;	/**	* This class is the setup class for the Stage	* This is the first class called on initialization	*/	public class Main extends MovieClip {		const cyanColor = "0x66FFFF";		var pifagor:MovieClip;		var instructions:TextField;		var checkboxes:Array;		//init		public function Main() {			extend();			addPifagor().at(this.stage.stageWidth/2 - pifagor.width/2, 20);			this.stage.color = int(cyanColor);			//Setup instructions text			with (instructions = new TextField) {				defaultTextFormat = new TextFormat("Times New Roman",22,null,true);				text = "Sort the figures!";				autoSize = TextFieldAutoSize.CENTER;			}			addChild(instructions).at(this.stage.stageWidth/2 - instructions.width/2, 150);			//Setup start button			addChild(new MenuButton).at(this.stage.stageWidth/2, 300).addEventListener(MouseEvent.CLICK, startGame);			//Setup checkboxes			checkboxes = [				new CheckBox(),				new CheckBox(),				new CheckBox()			];			const labels = [				"By Color",				"By Size",				"By Shape"			];			for (var i:int in checkboxes) {				const c:CheckBox = checkboxes[i]				with (c) {					//Set label text					label = labels[i]					//Arrange label to be below checkbox					labelPlacement = "bottom";					move(instructions.stage.stageWidth/4 * (i+1) - width/2, 220);				}				addChild(c);			}		}		public function startGame(e:MouseEvent) {			var labels = checkboxes.filter(				function(c:CheckBox, index:int, arr:Array){return c.selected == true}			).map(				function(c:CheckBox, index:int, arr:Array){return c.label.substring(3)}			);			trace(labels)		}		/**		* Adds the pifagor animation as a child		*		* Params:		*    {String} type - A string identifying what type of pifagor to add.		*  Can be either "Silent" or "Talking". Defaults to "Silent".		*/		public function addPifagor(type:String = "Silent"):DisplayObject {			switch (type) {				case "Silent":					pifagor = new PifagorSilent();					break;				case "Talking":					pifagor = new Pifagor();					break;				default:					pifagor = new PifagorSilent();					break;			}			return addChild(pifagor);		}		public function extend() {			/**			* Helper method, sets a MovieClip's position			* *Note*: This only works if you turn off strict mode in the compiler settings			*			* Params:			*     {Number} x - The x coordinate to add the child at			*     {Number} y - The y coordinate to add the child at			*/			DisplayObject.prototype.at = function(x:Number, y:Number) {				this.x = x;				this.y = y;				return this;			};		}	}}