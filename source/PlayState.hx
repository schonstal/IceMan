package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the game's menu.
 */
class PlayState extends FlxState
{
  var middleBar:FlxSprite;
  var player:Player;
  var pattern:Pattern;
  var indicator:FlxSprite;

  override public function create():Void {
    var bg = new FlxSprite();
    bg.makeGraphic(FlxG.width, FlxG.height, 0xff333333);
    add(bg);

    player = new Player();
    add(player);

    indicator = new FlxSprite();
    indicator.makeGraphic(Std.int(player.width), Std.int(player.width), 0xffffff00);
    add(indicator);


    middleBar = new FlxSprite();
    middleBar.makeGraphic(FlxG.width, 6, 0xffffff00);
    middleBar.y = FlxG.height/2-3;
    add(middleBar);

    pattern = new Pattern("assets/tilemaps/test.tmx");
    add(pattern.enemies);
    
    super.create();
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    FlxG.overlap(player, middleBar, function(p:Player, m:FlxSprite) {
      p.pingPong();
    });

    FlxG.overlap(player, pattern.enemies, function(p:Player, e:FlxSprite) {
      FlxG.camera.flash(0xff660000, 0.3);
    });

    indicator.x = player.x;
    if(player.y < FlxG.height/2) {
      indicator.y = FlxG.height - indicator.height;
    } else {
      indicator.y = 0;
    }
    super.update();
  }
}
