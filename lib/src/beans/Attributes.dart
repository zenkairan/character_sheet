
class Attributes{
  int _strength;
  int _dexterity;
  int _constitution;
  int _intelligence;
  int _wisdom;
  int _charisma;

  Attributes();
  
  Attributes.fromJson(Map<String, dynamic> json)
    :_strength = json['strength'],
    _dexterity = json['dexterity'],
    _constitution = json['constitution'],
    _intelligence = json['intelligence'],
    _wisdom = json['wisdom'],
    _charisma = json['charisma'];
  

  Map<String, dynamic> toJson() =>
  {
    'strength': _strength,
    'dexterity': _dexterity,
    'constitution': _constitution,
    'intelligence': _intelligence,
    'wisdom': _wisdom,
    'charisma': _charisma
  };
  
  void setStrength(int value){
    _strength = value;
  }
  void setDexterity(int value){
    _dexterity = value;
  }
  void setConstitution(int value){
    _constitution = value;
  }
  void setIntelligence(int value){
    _intelligence = value;
  }
  void setWisdom(int value){
    _wisdom = value;
  }
  void setCharisma(int value){
    _charisma = value;
  }


  int getStrenght(){
    return _strength;
  }
  int getDexterity(){
    return _dexterity;
  }
  int getConstitution(){
    return _constitution;
  }
  int getIntelligence(){
    return _intelligence;
  }
  int getWisdom(){
    return _wisdom;
  }
  int getCharisma(){
    return _charisma;
  }

  //mods
  int getStrenghtMod(){
    return ((_strength - 10)/ 2).round();
  }
  int getDexterityMod(){
    return ((_dexterity - 10)/ 2).round();
  }
  int getConstitutionMod(){
    return ((_constitution - 10)/ 2).round();
  }
  int getIntelligenceMod(){
    return ((_intelligence - 10)/ 2).round();
  }
  int getWisdomMod(){
    return ((_wisdom - 10)/ 2).round();
  }
  int getCharismaMod(){
    return ((_charisma - 10)/ 2).round();
  }
  //

  @override
    String toString() {
      return 'STR:' + _strength.toString() + ', '
            'DEX:' + _dexterity.toString() + ', '
            'CON:' + _constitution.toString() + ', '
            'INT:' + _intelligence.toString() + ', '
            'WIS:' + _wisdom.toString() + ', '
            'CHA:' + _charisma.toString() + ', ';
    }
}
