package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxObject;
import flixel.tweens.FlxTween;

/**
 * A FlxState which can be used for the game's menu.
 */
class PlayState extends FlxState
{
  var middleBar:FlxSprite;
  var player:Player;
  var indicator:FlxSprite;
  var waveController:WaveController;

  override public function create():Void {
    var bg = new ScrollingBackground();
    add(bg);

    player = new Player();
    add(player);

    indicator = new FlxSprite();
    indicator.loadGraphic("assets/images/playerPointer.png");
    indicator.width = player.width;
    indicator.offset.x = player.offset.x;
    indicator.setFacingFlip(FlxObject.DOWN, false, true);
    indicator.setFacingFlip(FlxObject.UP, false, false);
    indicator.alpha = 0;
    add(indicator);

    middleBar = new FlxSprite();
    middleBar.makeGraphic(FlxG.width, 6, 0xffffff00);
    middleBar.y = FlxG.height/2-3;
    add(middleBar);

    waveController = new WaveController();
    add(waveController);
    
    super.create();
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    FlxG.overlap(player, middleBar, function(p:Player, m:FlxSprite) {
      p.pingPong();
      FlxTween.tween(indicator, { alpha: 1 }, 0.6);
      //FlxG.camera.shake(0.01, 0.1);
    });

    FlxG.overlap(player, waveController, function(p:Player, e:FlxSprite) {
      FlxG.camera.flash(0xff660000, 0.3);
    });

    indicator.x = player.x;
    if(player.y < FlxG.height/2) {
      indicator.y = FlxG.height - indicator.height;
      indicator.facing = FlxObject.DOWN;
    } else {
      indicator.y = 0;
      indicator.facing = FlxObject.UP;
    }

    if(player.y < -player.height || player.y >= FlxG.height) indicator.alpha = 0;
    super.update();
  }
}
