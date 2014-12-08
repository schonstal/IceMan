package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.math.FlxRandom;

class Projectile extends FlxSprite
{
  public static var SPEED:Float = 100;

  var bounds:FlxObject;
  var localPosition:FlxPoint;
  static var rng:FlxRandom = new FlxRandom();

  static var pulseTimer:Float = 0;
  static var pulseRate:Float = 0.05;
  static var pulseFrame:Int = 0;

  var initialFrame:Int = 0;

  public function new(X:Float=0,Y:Float=100,bounds:FlxObject) {
    super(X,Y);
    loadGraphic("assets/images/orb.png", true, 16, 16);
    animation.add("pulse", [0, 1, 2, 3, 4, 5], 20);
    initialFrame = Y > FlxG.height / 2 ? 0 : 3;
    width = height = 6;
    offset.x = offset.y = 5;

    localPosition = new FlxPoint(X,Y);

    this.bounds = bounds;
  }

  public override function update():Void {
    super.update();
    x = localPosition.x + bounds.x;
    y = localPosition.y + bounds.y;

    animation.frameIndex = (pulseFrame + initialFrame) % 5;
  }

  public static function updatePulse():Void {
    pulseTimer += FlxG.elapsed;
    if (pulseTimer > pulseRate) {
      pulseTimer = 0;
      pulseFrame++;
    }
  }
}
