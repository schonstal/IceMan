package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;

class GameOverGroup extends FlxSpriteGroup
{
  var overlay:FlxSprite;

  public function new() {
    super();
    overlay = new FlxSprite();
    overlay.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    overlay.alpha = 0;
    add(overlay);
  }

  public function show() {
    FlxTween.tween(overlay, { alpha: 0.8 }, 0.2);
  }
}
