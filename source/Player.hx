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

  public function new(X:Float=0,Y:Float=100) {
    super(X,Y);
    makeGraphic(12, 16, 0xffff00ff);

//    acceleration.y = _gravity;

//    maxVelocity.y = 500;
    maxVelocity.x = SPEED;

    velocity.y = 250;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  override public function update():Void {
    checkScreenBounds();
    processMovementInput();

    super.update();
  }

  public function pingPong():Void {
    if(bouncable) velocity.y = -velocity.y;
    bouncable = false;
  }

  function checkScreenBounds():Void {
    if(y >= FlxG.height) {
      y = -height;
      bouncable = true;
    }
    if(y < -height) {
      y = FlxG.height;
      bouncable = true;
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
    } else if(FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
      velocity.x = SPEED;
    } else {
      velocity.x = 0;
    }
  }
}
