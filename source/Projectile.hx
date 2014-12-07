package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class Projectile extends FlxSprite
{
  public static var SPEED:Float = 100;

  var direction:Float;

  public function new(X:Float=0,Y:Float=100,direction:Float=1) {
    super(X,Y);
    makeGraphic(16,16,0xff00ffff);
    this.direction = direction;

    velocity.x = SPEED * direction;
  }

  public override function update():Void {
    if(direction < 0) {
      if(x < -width) x = FlxG.width;
    } else {
      if(x > FlxG.width) x = -width;
    }

    super.update();
  }
}
