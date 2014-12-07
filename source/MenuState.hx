package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
  override public function create():Void {
    FlxG.debugger.drawDebug = true;
    super.create();
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update():Void {
    FlxG.switchState(new PlayState());
    super.update();
  }
}
