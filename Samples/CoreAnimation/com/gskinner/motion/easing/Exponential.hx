/**        Haxe                                                   *                                                               ** Initial haXe port by Brett Johnson, http://now.periscopic.com   ** Project site: code.google.com/p/gtweenhx/                       ** . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . *** Exponential by Grant Skinner. Nov 3, 2009* Visit www.gskinner.com/blog for documentation, updates and more free code.** Adapted from Robert Penner's AS3 tweening equations.*** Copyright (c) 2009 Grant Skinner* * Permission is hereby granted, free of charge, to any person* obtaining a copy of this software and associated documentation* files (the "Software"), to deal in the Software without* restriction, including without limitation the rights to use,* copy, modify, merge, publish, distribute, sublicense, and/or sell* copies of the Software, and to permit persons to whom the* Software is furnished to do so, subject to the following* conditions:* * The above copyright notice and this permission notice shall be* included in all copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR* OTHER DEALINGS IN THE SOFTWARE.**/package com.gskinner.motion.easing;		/**	* Easing class for use with GTween. This ease class is not compatible with other tweening engines.	* GTween can use standard t,b,c,d format ease classes.	**/	class Exponential {				// unused params are included for compatibility with other easing classes.		public inline static function easeIn(ratio:Float, unused1:Float, unused2:Float, unused3:Float):Float {			return (ratio == 0) ? 0 : Math.pow(2, 10 * (ratio - 1));		}				public inline static function easeOut(ratio:Float, unused1:Float, unused2:Float, unused3:Float):Float {			return (ratio == 1) ? 1 : 1-Math.pow(2, -10 * ratio);		}				public inline static function easeInOut(ratio:Float, unused1:Float, unused2:Float, unused3:Float):Float {			if (ratio == 0 || ratio == 1) { return ratio; }			if (0 > (ratio = ratio*2-1)) { return 0.5*Math.pow(2, 10*ratio); }			return 1-0.5*Math.pow(2, -10*ratio);		}	}