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
  var title:FlxSprite;
  var beginText:FlxText;

  public function new() {
    super();
    overlay = new FlxSprite();
    overlay.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    overlay.alpha = 0.6;
    add(overlay);

    title = new FlxSprite();
    title.loadGraphic("assets/images/title.png");
    title.x = FlxG.width/2 - title.width/2;
    title.y = FlxG.height/4 - title.height/2;
    add(title);

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
    title.visible = false;
    FlxTween.tween(overlay, { alpha: 0 }, 0.2);
  }
}
