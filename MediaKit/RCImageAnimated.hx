//
//  3D Image simulation
//
//  Created by Baluta Cristian on 2008-04-01.
//  Copyright (c) 2008 http://ralcr.com. 
//	This software is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
//

import haxe.Timer;


class RCImageAnimated extends RCView {
	
	public var images :Array<RCImage>;
	public var currentFrame :Int;
	public var isLoaded :Bool;
	public var percentLoaded :Int;
	public var errorMessage :String;
	public var fps :Int;
	var nr :Int;
	var max :Int;
	var timer :Timer;
	
	
	dynamic public function onComplete () :Void {}
	dynamic public function onProgress () :Void {}
	dynamic public function onError () :Void {}
	
	
	public static function animatedImageWithImages (x, y, images:Array<RCImage>) {
		var im = new RCImageAnimated (x, y, null);
			im.images = images;
			im.gotoAndStop ( 1 );
		return im;
	}
	
	
	public function new (x, y, urls:Array<String>) {
		
		super (x, y);
		
		isLoaded = false;
		percentLoaded = 0;
		currentFrame = 0;
		fps = 10;
		nr = 0;
		max = 0;
		
		
		if (urls == null) return;
		
		images = new Array<RCImage>();
		
		for (url in urls) {
			var im = new RCImage (0, 0, url);
			im.onProgress = progressHandler;
			im.onError = errorHandler;
			im.onComplete = completeHandler;
			images.push ( im );
		}
		max = images.length;
	}
	
	// Controlling the animation
	
	public function gotoAndStop (f:Int) :Void {
		if (f == 0 || f > images.length)
			f = 1;
		if (currentFrame > 0)
			Fugu.safeRemove ( images[currentFrame-1] );
		addChild ( images[f-1] );
		currentFrame = f;
	}
	
	public function play (?newFPS:Null<Int>) :Void {
		
		if (newFPS != null) {
			fps = newFPS;
			stop();
		}
		
		if (timer == null) {
			timer = new Timer ( fps );
			timer.run = loop;
		}
	}
	
	public function stop () :Void {
		if (timer != null) {
			timer.stop();
			timer = null;
		}
	}
	
	function loop() {
		gotoAndStop ( currentFrame + 1 );
	}
	
	
	/**
	 *	Handlers.
	 */
	function completeHandler () :Void {
		onCompleteHandler();
	}
	function onCompleteHandler () :Void {
		nr ++;
		if (nr >= max)
			onComplete();
	}
	function progressHandler () :Void {
/*		percentLoaded = Math.round (e.target.bytesLoaded * 100 / e.target.bytesTotal);
		onProgress ();*/
	}
	function errorHandler () :Void {
		//errorMessage = e.toString();
		onError();
		onCompleteHandler();
	}
	
	
	override public function destroy() :Void {
		
		stop();
		Fugu.safeDestroy ( images );
		images = null;
		super.destroy();
	}
}
