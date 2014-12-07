package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class Projectile extends FlxSprite
{
  public static var SPEED:Float = 100;

  var bounds:FlxObject;
  var localPosition:FlxPoint;

  public function new(X:Float=0,Y:Float=100,bounds:FlxObject) {
    super(X,Y);
    loadGraphic("assets/images/orb.png", true, 16, 16);
    animation.add("pulse", [0, 1, 2, 3, 4, 5], 20);
    animation.play("pulse");

    localPosition = new FlxPoint(X,Y);

    this.bounds = bounds;
  }

  public override function update():Void {
    super.update();
    x = localPosition.x + bounds.x;
    y = localPosition.y + bounds.y;
  }
}
