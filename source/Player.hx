package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
  public static var SPEED:Float = 150;
  public static var JUMP_SPEED:Float = 250;

  var currentFallRate:Float = JUMP_SPEED;

  private var _speed:Point;
  private var _gravity:Float = 1200; 

  public var jumpAmount:Float = 300;

  private var bouncable:Bool = true;
  private var dead:Bool = true;

  private var horizontalFacing:Int = FlxObject.RIGHT;
  private var verticalFacing:Int = FlxObject.UP;

  public function new() {
    super();
    loadGraphic("assets/images/player.png", true, 16, 16);
    animation.add("up", [0, 2], 15, false);
    animation.add("down", [1], 15, false);
    animation.add("dead", [0]);
    animation.play("down");
    width = 7;
    offset.x = 4;
    x = FlxG.width/2 - 4;
    y = FlxG.width/4 - 7;
    immovable = true;

    height = 14;
    offset.y = 2;

//    acceleration.y = _gravity;

//    maxVelocity.y = 500;
    maxVelocity.x = SPEED;

    setFacingFlip(FlxObject.LEFT | FlxObject.UP, false, false);
    setFacingFlip(FlxObject.RIGHT | FlxObject.UP, true, false);

    setFacingFlip(FlxObject.LEFT | FlxObject.DOWN, false, true);
    setFacingFlip(FlxObject.RIGHT | FlxObject.DOWN, true, true);
  }

  override public function update():Void {
    if(!dead) {
      checkScreenBounds();
      processMovementInput();
    }
    facing = horizontalFacing | verticalFacing;
    offset.y = (facing & FlxObject.DOWN > 0 ? 0 : 1);


    if (!dead) velocity.y = currentFallRate;
    super.update();
  }

  public function pingPong():Void {
    if(bouncable) {
      animation.play("up");
      currentFallRate = -currentFallRate;
      FlxG.sound.play("assets/sounds/jump.wav", 0.3);
    }
    bouncable = false;
  }

  function checkScreenBounds():Void {
    if(y >= FlxG.height) {
      y = -height;
      bouncable = true;
      animation.play("down");
      verticalFacing = FlxObject.UP;
    }
    if(y < -height) {
      y = FlxG.height;
      bouncable = true;
      animation.play("down");
      verticalFacing = FlxObject.DOWN;
    }
    if(x > FlxG.width) x = -width;
    if(x < -width) x = FlxG.width;

//    if(y >= FlxG.height/2) acceleration.y = _gravity;
//    else acceleration.y = -_gravity;

    //if(y >= FlxG.height - height) jump();
  }

  function jump():Void {
    velocity.y = -JUMP_SPEED;
  }

  function processMovementInput():Void {
    if(FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
      velocity.x = -SPEED;
      horizontalFacing = FlxObject.LEFT;
    } else if(FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
      velocity.x = SPEED;
      horizontalFacing = FlxObject.RIGHT;
    } else {
      velocity.x = 0;
    }
  }

  public function die():Void {
    dead = true;
    velocity.x = velocity.y = 0;
    animation.play("dead");
    FlxG.timeScale = 0.5;
  }

  public function respawn():Void {
    dead = false;
  }

  public function isAlive():Bool {
    return !dead;
  }
}
