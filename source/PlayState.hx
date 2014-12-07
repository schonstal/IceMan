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

  override public function create():Void {
    player = new Player();
    add(player);

    middleBar = new FlxSprite();
    middleBar.makeGraphic(FlxG.width, 2, 0xffffff00);
    middleBar.y = FlxG.height/2-1;
    add(middleBar);
    
    super.create();
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    FlxG.overlap(player, middleBar, function(p:Player, m:FlxSprite) {
      p.pingPong();
    });
    super.update();
  }
}
