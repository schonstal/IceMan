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
  public var inverted:Bool;

  var activeSprite:FlxSprite;
  var bufferSprite:FlxSprite;

  public function new(image:String, Z:Float, invert:Bool=false) {
    super();

    inverted = invert;

    z = Z;

    activeSprite = new FlxSprite(0, invert ? FlxG.height/2 : 0);
    activeSprite.loadGraphic(image);
    if (!invert) activeSprite.y = FlxG.height/2 - activeSprite.height;
    add(activeSprite);

    bufferSprite = new FlxSprite(activeSprite.width, activeSprite.y);
    bufferSprite.loadGraphic(image);
    if (!invert) bufferSprite.y = FlxG.height/2 - bufferSprite.height;
    add(bufferSprite);

    if (invert) {
      activeSprite.setFacingFlip(FlxObject.DOWN, true, true);
      bufferSprite.setFacingFlip(FlxObject.DOWN, true, true);
      activeSprite.facing = FlxObject.DOWN;
      bufferSprite.facing = FlxObject.DOWN;
    }
  }

  public override function update():Void {
    super.update();

    activeSprite.velocity.x = z * ScrollingBackground.SCROLL_SPEED * direction();

    if (inverted ? activeSprite.x > FlxG.width : activeSprite.x < -activeSprite.width) {
      var sprite:FlxSprite = activeSprite;
      activeSprite = bufferSprite;
      bufferSprite = sprite;
    }

    bufferSprite.x = activeSprite.x + (activeSprite.width * direction() * -1);
  }

  function direction():Int {
    return inverted ? 1 : -1;
  }
}
