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

  var waveIndex = 0;

  public function new() {
    super();
    tiles = new TiledMap("assets/tilemaps/patterns.tmx");
    
    loadObjects();
  } // new()
  
  public function loadObjects() {
    for (group in tiles.objectGroups) {
      var wave = new Wave(-1);
      add(wave);

      for (o in group.objects) {
        wave.loadObject(o, group, waveIndex);
      }
      waveIndex++;
    }
  } //loadObjects()
}
