package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.math.FlxRandom;

class BackgroundLayer extends FlxSpriteGroup
{
  public var z:Float = 0;

  var sprites:Array<FlxSprite> = [];

  public function new(image:String, Z:Float) {
    super();

    z = Z;

    var bgSprite = new FlxSprite();
    bgSprite.loadGraphic(image);
    sprites.push(bgSprite);
    add(bgSprite);
  }

  public override function update():Void {
    super.update();
    velocity.x = z * ScrollingBackground.SCROLL_SPEED;
  }
}
