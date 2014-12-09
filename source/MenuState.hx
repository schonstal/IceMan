package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
  override public function create():Void {
    super.create();
    
    FlxG.sound.play("assets/sounds/bading.mp3");
    
    var logo:FlxSprite = new FlxSprite();
    logo.loadGraphic("assets/images/logo.png");
    add(logo);

    new FlxTimer(1, function(t):Void {
      logo.visible = false;
      new FlxTimer(0.5, function(t):Void {
        FlxG.switchState(new PlayState());
      });
    });
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    super.update();
  }
}
