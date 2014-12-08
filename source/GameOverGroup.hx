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
import flixel.text.FlxText;

class GameOverGroup extends FlxSpriteGroup
{
  var overlay:FlxSprite;
  var tryAgainText:FlxText;

  public function new() {
    super();
    overlay = new FlxSprite();
    overlay.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    overlay.alpha = 0;
    add(overlay);

    tryAgainText = new FlxText();
    tryAgainText = new FlxText(0, FlxG.width/4 - 8, FlxG.width);
    tryAgainText.setFormat("assets/fonts/04b03.ttf");
    tryAgainText.size = 16;
    tryAgainText.alignment = "center";
    tryAgainText.text = "press [SPACE] to continue";
    tryAgainText.visible = false;
    add(tryAgainText);
  }

  public function show(bottom:Bool = false) {
    if(bottom) {
      tryAgainText.y = FlxG.width * (3/4) - 8;
      tryAgainText.color = 0xfff9c0e6;
    } else {
      tryAgainText.color = 0xffc2fafa;
    }
    tryAgainText.visible = true;
    FlxTween.tween(overlay, { alpha: 0.6 }, 0.1);
  }
}
