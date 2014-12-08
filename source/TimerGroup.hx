package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.math.FlxRandom;

class TimerGroup extends FlxGroup
{
  public var time:Int = 0;

  var minutes:NumberGroup;
  var seconds:NumberGroup;
  var hundredths:NumberGroup;

  public function new() {
    super();

    minutes    = new NumberGroup(10,10);
    seconds    = new NumberGroup(34,10);
    hundredths = new NumberGroup(58,10);

    add(minutes);
    add(seconds);
    add(hundredths);
  }

  override public function update():Void {
    minutes.number    = Std.int(time / 60000);
    seconds.number    = Std.int((time / 1000) % 60);
    hundredths.number = Std.int((time / 10) % 100);

    super.update();
  }
}
