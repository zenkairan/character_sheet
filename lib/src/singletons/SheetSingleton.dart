import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/beans/Character.dart';

class SheetSingleton {
  static final SheetSingleton _sheetsingleton = new SheetSingleton._internal();
  Character character;
  Attributes attributes;

  factory SheetSingleton(){
    return _sheetsingleton;
  }

  SheetSingleton._internal();
}