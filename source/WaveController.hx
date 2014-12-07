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
    for (i in (0...2)) {
      var wave = new Wave(false, i);
      waves.push(wave);
      add(wave);

      var reverseWave = new Wave(true, -i);
      reverseWaves.push(reverseWave);
      add(reverseWave);

      wave.loadMapObjects(tiles.objectGroups);
      reverseWave.loadMapObjects(tiles.objectGroups);
      wave.initialize();
      reverseWave.initialize();
    }
  } //loadObjects()

  public override function update():Void {
    super.update();
  }
}
