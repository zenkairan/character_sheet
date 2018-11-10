import 'package:character_sheet/src/beans/Skills.dart';


class Attributes{
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;

  Attributes();
  
  Attributes.fromJson(Map<String, dynamic> json)
    :strength = json['strength'],
    dexterity = json['dexterity'],
    constitution = json['constitution'],
    intelligence = json['intelligence'],
    wisdom = json['wisdom'],
    charisma = json['charisma'];
  

  Map<String, dynamic> toJson() =>
  {
    'strength': strength,
    'dexterity': dexterity,
    'constitution': constitution,
    'intelligence': intelligence,
    'wisdom': wisdom,
    'charisma': charisma
  };
  


  //mods
  int getStrenghtMod(){
    return ((strength - 10)~/ 2).toInt();
  }
  int getDexterityMod(){
    return ((dexterity - 10)~/ 2).toInt();
  }
  int getConstitutionMod(){
    return ((constitution - 10)~/ 2).toInt();
  }
  int getIntelligenceMod(){
    return ((intelligence - 10)~/ 2).toInt();
  }
  int getWisdomMod(){
    return ((wisdom - 10)~/ 2).toInt();
  }
  int getCharismaMod(){
    return ((charisma - 10)~/ 2).toInt();
  }
  //

  int modByIndex(AttList att){
    int value = 0;
    switch (att) {
      case AttList.strength:
        value = getStrenghtMod();
        break;
      case AttList.dexterity:
        value = getDexterityMod();
        break;
      case AttList.intelligence:
        value = getIntelligenceMod();
        break;
      case AttList.constitution:
        value = getConstitutionMod();
        break;
      case AttList.wisdom:
        value = getWisdomMod();
        break;
      case AttList.charisma:
        value = getCharismaMod();
        break;
      default:
    }
    return value;
  }

  @override
    String toString() {
      return 'STR:' + strength.toString() + ', '
            'DEX:' + dexterity.toString() + ', '
            'CON:' + constitution.toString() + ', '
            'INT:' + intelligence.toString() + ', '
            'WIS:' + wisdom.toString() + ', '
            'CHA:' + charisma.toString() + ', ';
    }
}
