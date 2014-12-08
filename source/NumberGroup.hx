package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;

class NumberGroup extends FlxSpriteGroup
{
  public var number:Int;

  var ones:FlxSprite;
  var tens:FlxSprite;

  public function new(X,Y) {
    super();
    ones = new FlxSprite(X+12,Y);
    ones.loadGraphic("assets/images/numbers.png", true, 10, 8);
    ones.animation.add("numbers", [0,1,2,3,4,5,6,7,8,9], 1);
    add(ones);

    tens = new FlxSprite(X,Y);
    tens.loadGraphic("assets/images/numbers.png", true, 10, 8);
    tens.animation.add("numbers", [0,1,2,3,4,5,6,7,8,9], 1);
    add(tens);
  }

  override public function update():Void {
    super.update();
    ones.animation.frameIndex = number % 10; 
    tens.animation.frameIndex = Std.int(number / 10);
  }
}
