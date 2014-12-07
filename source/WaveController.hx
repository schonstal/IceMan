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

class WaveController extends FlxTypedGroup<Wave>
{
  var tiles:TiledMap;

  var waves:Array<Wave> = [];
  var reverseWaves:Array<Wave> = [];

  public function new() {
    super();
    tiles = new TiledMap("assets/tilemaps/patterns.tmx");
    
    loadObjects();
  } // new()
  
  public function loadObjects() {
    var index = 0;
    for (group in tiles.objectGroups) {
      var wave = new Wave(false, index);
      waves.push(wave);
      add(wave);

      var reverseWave = new Wave(true, index);
      reverseWaves.push(reverseWave);
      add(reverseWave);

      for (o in group.objects) {
        wave.loadObject(o, group);
        reverseWave.loadObject(o, group);
      }
      index++;
    }
  } //loadObjects()

  public override function update():Void {
    super.update();
  }
}
