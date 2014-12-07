package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
  public static var SPEED:Float = 150;
  public static var JUMP_SPEED:Float = 400;

  private var _speed:Point;
  private var _gravity:Float = 1200; 

  public var jumpAmount:Float = 300;

  private var bouncable:Bool = true;

  private var horizontalFacing:Int = FlxObject.RIGHT;
  private var verticalFacing:Int = FlxObject.UP;

  public function new(X:Float=0,Y:Float=100) {
    super(X,Y);
    loadGraphic("assets/images/player.png", true, 16, 16);
    animation.add("up", [0, 2], 15, false);
    animation.add("down", [1], 15, false);
    animation.play("down");

//    acceleration.y = _gravity;

//    maxVelocity.y = 500;
    maxVelocity.x = SPEED;

    velocity.y = 250;

    setFacingFlip(FlxObject.LEFT | FlxObject.UP, false, false);
    setFacingFlip(FlxObject.RIGHT | FlxObject.UP, true, false);

    setFacingFlip(FlxObject.LEFT | FlxObject.DOWN, false, true);
    setFacingFlip(FlxObject.RIGHT | FlxObject.DOWN, true, true);
  }

  override public function update():Void {
    checkScreenBounds();
    processMovementInput();
    facing = horizontalFacing | verticalFacing;

    super.update();
  }

  public function pingPong():Void {
    if(bouncable) {
      animation.play("up");
      velocity.y = -velocity.y;
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
}
