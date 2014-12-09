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
import flash.display.BlendMode;

class TitleGroup extends FlxSpriteGroup
{
  var overlay:FlxSprite;
  var beginText:FlxText;
  var titleText:FlxText;

  public function new() {
    super();
    overlay = new FlxSprite();
    overlay.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    overlay.alpha = 0.6;
    add(overlay);

    titleText = new FlxText();
    titleText = new FlxText(0, 0, FlxG.width);
    titleText.y = FlxG.width/4 - 8;
    titleText.setFormat("assets/fonts/04b03.ttf");
    titleText.size = 16;
    titleText.color = 0xfff9c0e6;
    titleText.alignment = "center";
    titleText.text = "GAME NAME";
    //add(titleText);

    beginText = new FlxText();
    beginText = new FlxText(0, 0, FlxG.width);
    beginText.y = FlxG.width * (3/4) - 8;
    beginText.setFormat("assets/fonts/04b03.ttf");
    beginText.size = 16;
    beginText.color = 0xfff9c0e6;
    beginText.alignment = "center";
    beginText.text = "press [SPACE] to begin";
    add(beginText);
  }

  public function hide():Void {
    beginText.visible = false;
    titleText.visible = false;
    FlxTween.tween(overlay, { alpha: 0 }, 0.2);
  }
}
