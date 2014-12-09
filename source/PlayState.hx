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
import flixel.addons.api.FlxKongregate;

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
  var inverter:FlxSprite;

  var hyperMode:Bool = false;
  var elapsed:Int = 0;

  var hyperGlyph:FlxSprite;

  override public function create():Void {
    if (!Reg.apiInitialized) {
      //FlxKongregate.init(function():Void {
        //Reg.apiInitialized = true;
      //});
    }
    Reg.difficultyMin = 0;
    Reg.difficultyMax = 1;

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

    timerGroup = new TimerGroup(FlxG.width/4 - 54, FlxG.height/2 - 7);
    add(timerGroup);

    highScoreTimer = new TimerGroup(FlxG.width * (3/4) - 45, FlxG.height/2 - 7);
    highScoreTimer.disabled = true;
    add(highScoreTimer);

    titleGroup = new TitleGroup();
    add(titleGroup);

    hyperGlyph = new FlxSprite();
    hyperGlyph.loadGraphic("assets/images/hyper.png");
    hyperGlyph.x = FlxG.width/2 - hyperGlyph.width/2;
    hyperGlyph.y = FlxG.height/2 - hyperGlyph.height/2;
    hyperGlyph.visible = false;
    add(hyperGlyph);

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

    inverter = new FlxSprite();
    inverter.makeGraphic(FlxG.width, FlxG.height, 0xffffffff);
    inverter.blend = BlendMode.INVERT;

    FlxG.timeScale = 0.5;

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
      if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.W || FlxG.keys.justPressed.S) {
        hyperMode = !hyperMode;
        if(hyperMode) {
          FlxG.sound.play("assets/sounds/hyperOn.wav");
        } else {
          FlxG.sound.play("assets/sounds/hyperOff.wav");
        }
      }
    }

    updateTime();
    adjustDifficulty();

    if (hyperMode) {
      hyperGlyph.visible = true;
    } else {
      hyperGlyph.visible = false;
    }
  }

  private function adjustDifficulty():Void {
    if (hyperMode) {
      Reg.difficultyMin = 2;
      Reg.difficultyMax = 4;
    } else {
      if (elapsed > 5000) {
        Reg.difficultyMin = 1;
        Reg.difficultyMax = 1;
      }
      if (elapsed > 10000) {
        Reg.difficultyMax = 2;
      }
      if (elapsed > 20000) {
        Reg.difficultyMax = 3;
      }
      if (elapsed > 30000) {
        Reg.difficultyMin = 2;
      }
      if (elapsed > 45000) {
        Reg.difficultyMax = 4;
      }
      if (elapsed > 60000) {
        Reg.difficultyMin = 3;
      }
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

    if (Reg.apiInitialized) {
      if(!hyperMode) {
        FlxKongregate.submitStats("Time Survived (Normal)", elapsed/1000);
      } else {
        FlxKongregate.submitStats("Time Survived (Hyper)", elapsed/1000);
      }
    }
  }

  @:access(flixel.system.FlxSound)
  function startGame():Void {
    if (hyperMode) {
      Reg.difficultyMin = 2;
      Reg.difficultyMax = 4;
    } else {
      Reg.difficultyMin = 0;
      Reg.difficultyMax = 1;
    }

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
    highScoreTimer.disabled = true;
    titleGroup.hide();
  }

  override public function draw():Void {
    super.draw();
    if (hyperMode) inverter.draw();
  }

  function elapsedTime():Int {
    return Std.int(Date.now().getTime() - startTime.getTime());
  }

  function updateTime():Void {
    if (player.isAlive()) {
      elapsed = elapsedTime();
    }
    timerGroup.time = elapsed;

    if (hyperMode) {
      if(Reg.save.data.highScoreHyper == null || Reg.save.data.highScoreHyper < elapsed) {
        Reg.save.data.highScoreHyper = elapsed;
        highScoreTimer.disabled = false;
      }
      highScoreTimer.time = Reg.save.data.highScoreHyper;
    } else {
      if(Reg.save.data.highScore == null || Reg.save.data.highScore < elapsed) {
        Reg.save.data.highScore = elapsed;
        highScoreTimer.disabled = false;
      }
      highScoreTimer.time = Reg.save.data.highScore;
    }
  }
}
