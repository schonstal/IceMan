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


/**
 * Modified from Samuel Batista's example source
 */
class PatternController extends TiledMap
{
  // Do we reload objects?
  public var dirty:Bool = true;
  
  public var enemies:FlxGroup;

  public function new(tiles:Dynamic) {
    super(tiles);
    
    enemies = new FlxGroup();
    FlxG.state.add(enemies);
    loadObjects();
  } // new()
  
  public function loadObjects() {
    if (!dirty) return;

    for (group in objectGroups) {
      for (o in group.objects) {
        loadObject(o, group);
      }
    }
    dirty = false;
  }
  
  private function loadObject(o:TiledObject, g:TiledObjectGroup) {
    var x:Int = o.x;
    var y:Int = o.y;

    // objects in tiled are aligned bottom-left (top-left in flixel)
    if (o.gid != -1) {
      y -= g.map.getGidOwner(o.gid).tileHeight;
    }

    var projectile = new Projectile(-x, FlxG.height - y - 16, 1);
    enemies.add(projectile);

    var projectile = new Projectile(FlxG.width + x, y, -1);
    enemies.add(projectile);
  }
}
