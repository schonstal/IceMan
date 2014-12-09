package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.addons.text.FlxBitmapFont;
import flixel.util.FlxSave;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flash.display.BlendMode;

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

  var timerGroup:TimerGroup;
  var highScoreTimer:TimerGroup;
  var activeProjectile:FlxObject;

  var rng = new FlxRandom();

  var musicSound:FlxSound;

  var indicatorWasVisible:Bool = false;

  var playerSplash:PlayerSplash;
  var titleGroup:TitleGroup;
  var overlay:FlxSprite;

  override public function create():Void {
    var bg = new ScrollingBackground();
    add(bg);

    bg = new ScrollingBackground(true);
    add(bg);

//    Reg.patternTest = 5;

    Reg.save = new FlxSave();
    Reg.save.bind("scores");

    indicator = new FlxSprite();
    indicator.loadGraphic("assets/images/playerPointer.png");
    indicator.setFacingFlip(FlxObject.DOWN, false, true);
    indicator.setFacingFlip(FlxObject.UP, false, false);
    indicator.alpha = 0;
    indicator.visible = false;
    add(indicator);

    middleBar = new FlxSprite();
    middleBar.makeGraphic(FlxG.width, 18, 0x00);
    middleBar.y = FlxG.height/2-9;
    middleBar.immovable = true;
    add(middleBar);

    gameOverGroup = new GameOverGroup();
    add(gameOverGroup);

    timerGroup = new TimerGroup(FlxG.width/4 - 44, FlxG.height/2 - 7);
    add(timerGroup);

    highScoreTimer = new TimerGroup(FlxG.width * (3/4) - 44, FlxG.height/2 - 7);
    highScoreTimer.disabled = true;
    add(highScoreTimer);

    titleGroup = new TitleGroup();
    add(titleGroup);

    player = new Player();
    indicator.width = player.width;
    indicator.offset.x = player.offset.x;

    playerSplash = new PlayerSplash(player);
    add(playerSplash);
    add(player);

    musicSound = FlxG.sound.play("assets/music/mental_health.wav", 1, true);
    musicSound.pause();

    overlay = new FlxSprite();
    overlay.loadGraphic("assets/images/gradient.png");
    overlay.blend = BlendMode.HARDLIGHT;
    add(overlay);
    super.create();
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    indicator.x = player.x;
    if(player.y < FlxG.height/2) {
      indicator.y = FlxG.height - indicator.height;
      indicator.facing = FlxObject.DOWN;
      indicator.alpha = (FlxG.height/2 - player.y) / (FlxG.height/2);
    } else {
      indicator.y = 0;
      indicator.facing = FlxObject.UP;
      indicator.alpha = (player.y - FlxG.height/2) / (FlxG.height/2);
    }

    if(player.y < -player.height || player.y >= FlxG.height) {
      indicator.visible = false;
    }
    super.update();

    FlxG.overlap(player, waveController, gameOver);

    FlxG.overlap(player, middleBar, function(p:Player, m:FlxSprite) {
      if (p.velocity.y > 0) {
        p.y = m.y - p.height;
      } else {
        p.y = m.y + m.height;
      }

      p.pingPong();
      playerSplash.splash();
      indicator.visible = true;
      //FlxG.camera.shake(0.01, 0.1);
    });


    Projectile.updatePulse();
    if (!player.isAlive()) {
      if (FlxG.keys.justPressed.SPACE) {
        startGame();
        //FlxG.switchState(new PlayState());
      }
    } else {
      updateTime();
    }
  }

  private function gameOver(p:Player, e:FlxObject) {
    // ur already dead m8
    if (!player.isAlive()) return;

    FlxG.camera.flash(0xff660000, 0.3);
    FlxG.camera.shake(0.02, 0.2);
    player.die();
    remove(waveController);
    indicatorWasVisible = indicator.visible;
    indicator.visible = false;
    gameOverGroup.show(player.y < FlxG.height/2);
    musicSound.pause();
    FlxG.sound.play("assets/sounds/die.wav");
    activeProjectile = e;
    add(activeProjectile);
  }

  @:access(flixel.system.FlxSound)
  function startGame():Void {
    player.respawn();
    FlxG.timeScale = 1;
    startTime = Date.now();
    musicSound.time = Reg.songPositions[Reg.songIndex];
    if(++Reg.songIndex >= Reg.songPositions.length) {
      Reg.songIndex = 0;
      Reg.songPositions = rng.shuffleArray(Reg.songPositions, 20);
    }
    musicSound.resume();
    gameOverGroup.hide();

    remove(waveController);
    waveController = new WaveController();
    add(waveController);

    remove(activeProjectile);
    activeProjectile = null;
    indicator.visible = indicatorWasVisible;
    titleGroup.hide();
  }

  function elapsedTime():Int {
    return Std.int(Date.now().getTime() - startTime.getTime());
  }

  function updateTime():Void {
    var elapsed:Int = elapsedTime();
    timerGroup.time = elapsed;
    if(Reg.save.data.highScore == null || Reg.save.data.highScore < elapsed) {
      Reg.save.data.highScore = elapsed;
      highScoreTimer.disabled = false;
    }
    highScoreTimer.time = Reg.save.data.highScore;
  }
}
