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


class Wave extends FlxGroup
{
  public var bounds:FlxObject;
  var inverted:Bool;

  var index:Int = 0;
  var patternIndex:Int = 0;
  var rng:FlxRandom = new FlxRandom();

  public static var SPEED:Float = 100;

  var patterns:Array<FlxGroup> = [];

  public function new(inverted:Bool, index:Int) {
    super();

    this.inverted = inverted;
    this.index = index;

    bounds = new FlxObject(index * FlxG.width);
    bounds.width = FlxG.width;
    bounds.height = FlxG.height;
    bounds.velocity.x = SPEED * (inverted ? 1 : -1);
    bounds.allowCollisions = 0;
    add(bounds);
  } // new()
  
  public function loadObject(o:TiledObject, g:TiledObjectGroup, patternGroup:FlxGroup) {
    var x:Int = o.x;
    var y:Int = o.y;

    // objects in tiled are aligned bottom-left (top-left in flixel)
    if (o.gid != -1) {
      y -= g.map.getGidOwner(o.gid).tileHeight;
    }

    if (inverted) {
      var projectile = new Projectile(-x - 16, FlxG.height - y - 16 + 9, bounds);
      patternGroup.add(projectile);
    } else {
      var projectile = new Projectile(FlxG.width + x, y, bounds);
      patternGroup.add(projectile);
    }
  }

  public function loadMapObjects(groups:Array<TiledObjectGroup>):Void {
    for (group in groups) {
      var patternGroup = new FlxGroup();
      patterns.push(patternGroup);

      for (o in group.objects) {
        loadObject(o, group, patternGroup);
      }
    }
  }

  public override function update():Void {
    super.update();
    checkEdges();
  }

  function checkEdges():Void {
    if (inverted ? bounds.x >= FlxG.width * 2 : bounds.x <= -FlxG.width * 2) {
      bounds.x = bounds.x + FlxG.width * 2 * (inverted ? -1 : 1);
      initialize();
    }
  }

  // Reduce, reuse, recycle
  public function initialize():Void {
    remove(patterns[patternIndex]);
    patternIndex = Reg.patternTest >= 0 ? Reg.patternTest : rng.int(0, patterns.length-1);
    add(patterns[patternIndex]);
  }
}
