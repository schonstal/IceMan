package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;

class PlayerSplash extends FlxSprite
{
  var player:Player;

  public function new(p:Player) {
    super();
    player = p;
    loadGraphic("assets/images/poof.png", true, 32, 16);
    animation.add("poof", [1,2, 3, 4, 5, 0], 20, false);
    animation.add("poofRight", [7, 8, 9, 10, 11, 6], 20, false);
    animation.add("poofLeft", [13, 14, 15, 16, 17, 12], 20, false);
    alpha = 0.5;

    setFacingFlip(FlxObject.LEFT | FlxObject.UP, false, false);
    setFacingFlip(FlxObject.RIGHT | FlxObject.UP, false, false);

    setFacingFlip(FlxObject.LEFT | FlxObject.DOWN, false, true);
    setFacingFlip(FlxObject.RIGHT | FlxObject.DOWN, false, true);
  }

  public function splash():Void {
    facing = player.facing;
    x = player.x - 13;
    y = FlxG.height/2 + (player.y < FlxG.height/2 ? -height - 9 : 9);
    if (player.velocity.x < 0) {
      animation.play("poofLeft");
    } else if (player.velocity.x > 0) {
      animation.play("poofRight");
    } else {
      animation.play("poof");
    }
  }
}
