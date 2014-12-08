package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
  public static var save:FlxSave;

  // Which color palette to use
  public static var palette:Int = 1;

  public static var patternTest:Int = -1;
  
  public static var songPositions:Array<Float> = [0, 21315, 52665, 42652, 9829, 26666];
  public static var songIndex:Int = 0;
}
