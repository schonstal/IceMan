package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.math.FlxRandom;

class ScrollingBackground extends FlxGroup
{
  public static var SCROLL_SPEED:Float = 300;

  public function new(invert:Bool = false) {
    super();
    
    add(new BackgroundLayer("assets/images/backgrounds/top/1.png", 0.65, invert));
    add(new BackgroundLayer("assets/images/backgrounds/" + (invert ? "bottom" : "top") + "/0.png", 1, invert));
    add(new BackgroundLayer("assets/images/backgrounds/" + (invert ? "bottom" : "top") + "/ground.png", 1.1, invert));
  }
}
