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

class Wave extends FlxGroup
{
  var bounds:FlxObject;
  var inverted:Bool;

  public static var SPEED:Float = 100;

  public function new(inverted:Bool = false) {
    super();

    this.inverted = inverted;

    bounds = new FlxObject();
    bounds.width = FlxG.width;
    bounds.height = FlxG.height;
    bounds.velocity.x = SPEED * (inverted ? 1 : -1);
    FlxG.state.add(bounds);
  } // new()
  
  public function loadObject(o:TiledObject, g:TiledObjectGroup, windex:Int) {
    var x:Int = o.x;
    var y:Int = o.y;

    // objects in tiled are aligned bottom-left (top-left in flixel)
    if (o.gid != -1) {
      y -= g.map.getGidOwner(o.gid).tileHeight;
    }

    if (inverted) {
      var projectile = new Projectile(-x - FlxG.width*windex, FlxG.height - y - 16, bounds);
      add(projectile);
    } else {
      var projectile = new Projectile(FlxG.width + x + FlxG.width*windex, y, bounds);
      add(projectile);
    }
  }
}
