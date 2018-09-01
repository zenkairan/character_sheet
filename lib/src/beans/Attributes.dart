
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
    return ((strength - 10)/ 2).round();
  }
  int getDexterityMod(){
    return ((dexterity - 10)/ 2).round();
  }
  int getConstitutionMod(){
    return ((constitution - 10)/ 2).round();
  }
  int getIntelligenceMod(){
    return ((intelligence - 10)/ 2).round();
  }
  int getWisdomMod(){
    return ((wisdom - 10)/ 2).round();
  }
  int getCharismaMod(){
    return ((charisma - 10)/ 2).round();
  }
  //

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
