import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/beans/Character.dart';
import 'package:character_sheet/src/beans/Skills.dart';

class SheetSingleton {
  static final SheetSingleton _sheetsingleton = new SheetSingleton._internal();
  Character character;
  Attributes attributes;
  Skills skills;

  factory SheetSingleton(){
    return _sheetsingleton;
  }

  SheetSingleton._internal();
}