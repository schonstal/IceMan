package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.addons.text.FlxBitmapFont;

/**
 * A FlxState which can be used for the game's menu.
 */
class PlayState extends FlxState
{
  var middleBar:FlxSprite;
  var player:Player;
  var indicator:FlxSprite;
  var gameOverGroup:GameOverGroup;
  var waveController:WaveController;
  var startTime:Date;
  var testText:FlxText;

  override public function create():Void {
    var bg = new ScrollingBackground();
    add(bg);

    bg = new ScrollingBackground(true);
    add(bg);

    indicator = new FlxSprite();
    indicator.loadGraphic("assets/images/playerPointer.png");
    indicator.setFacingFlip(FlxObject.DOWN, false, true);
    indicator.setFacingFlip(FlxObject.UP, false, false);
    indicator.alpha = 0;
    add(indicator);

    middleBar = new FlxSprite();
    middleBar.makeGraphic(FlxG.width, 16, 0xffffff00);
    middleBar.y = FlxG.height/2-8;
    add(middleBar);

    gameOverGroup = new GameOverGroup();
    add(gameOverGroup);

    player = new Player();
    indicator.width = player.width;
    indicator.offset.x = player.offset.x;
    add(player);

    waveController = new WaveController();
    add(waveController);

    testText = new FlxText();
    add(testText);

    super.create();

    startGame();
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

    FlxG.overlap(player, waveController, gameOver);

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

    Projectile.updatePulse();
    if (!player.isAlive()) {
      if (FlxG.keys.justPressed.SPACE) {
        FlxG.switchState(new PlayState());
      }
    } else {
      var elapsed = Date.now().getTime() - startTime.getTime();
      testText.text = "" + Std.int(elapsed / 60000) + ":" + Std.int(elapsed / 1000) + ":" + Std.int((elapsed / 10) % 100);
    }
  }

  private function gameOver(p:Player, e:FlxObject) {
    // ur already dead m8
    if (!player.isAlive()) return;

    FlxG.camera.flash(0xff660000, 0.3);
    FlxG.camera.shake(0.02, 0.2);
    player.die();
    remove(waveController);
    indicator.visible = false;
    gameOverGroup.show();
    add(e);
  }

  function startGame():Void {
    FlxG.timeScale = 1;
    FlxG.camera.flash(0xffdddddd, 0.3);
    startTime = Date.now();
  }
}
