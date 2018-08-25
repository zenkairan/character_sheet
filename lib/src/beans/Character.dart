enum Classes {
  barbarian,
  bard,
  druid,
  monk,
  paladin,
  ranger,
  sorcerer,
  warlock
}
enum Races{
  aarakocra,
  aasimar,
  bugbear,
  centaur,
  changeling,
  dragonborn,
  dwarf,
  elf,
  tiefling,
  firbolg,
  genasi,
  gith,
  gnome,
  goblin,
  goliath,
  halfElf,
  halfling,
  halfOrc,
  hobgoblin,
  human,
  kalashtar,
  kenku,
  kobold,
  lizardfolk,
  minotaur,
  orc,
  shifter,
  tabaxi,
  tortle,
  triton,
  warforged,
  yanTi
}
enum Alinhamento{
  lawfulGood,
  neutralGood,
  chaoticGood,
  lawfulNeutral,
  neutral,
  chaoticNeutral,
  lawfulEvil,
  neutralEvil,
  chaoticEvil
}

class Character{
  String _name;
  Classes _classe;
  int _level;
  Races _race;
  int _xp;
  Alinhamento _alinhamento;

  Character();

  Character.fromJson(Map<String, dynamic> json)
  :_name = json['name'],
  _classe = Classes.values[json['classe']] ,
  _race = Races.values[json['race']],
  _xp = json['xp'],
  _alinhamento = Alinhamento.values[json['alinhamento']];

  Map<String, dynamic> toJson() =>
  {
    'name': _name,
    'classe':_classe.index,
    'race':_race.index,
    'xp':_xp,
    'alinhamento':_alinhamento.index
  };

  //get set
  void setName(String value){
    _name = value;
  }
  void setClasse(Classes value){
    _classe = value;
  }
  void setRace(Races value){
    _race = value;
  }
  void setXp(int value){
    _xp = value;
    _setLevel();
  }
  void setAlinhamento(Alinhamento value){
    _alinhamento = value;
  }
  
  String getNome(){
    return _name;
  }
  Classes getClasse(){
    return _classe;
  }
  int getLevel(){
    if(_level == null && _xp != null){
      _setLevel();
    }
    return _level == null? 0: _level;
  }
  Races getRace(){
    return _race;
  }
  int getXp(){
    return _xp;
  }
  Alinhamento getAlinhamento(){
    return _alinhamento;
  }


  void _setLevel(){
    int exp = _xp;
    if(exp < 300){
      _level = 1;
      return;
    }
    if(exp < 900){
      _level = 2;
      return;
    }
    if(exp < 2700){
      _level = 3;
      return;
    }
    if(exp < 6500){
      _level = 4;
      return;
    }
    if(exp < 14000){
      _level = 5;
      return;
    }
    if(exp < 23000){
      _level = 6;
      return;
    }
    if(exp < 34000){
      _level = 7;
      return;
    }
    if(exp < 48000){
      _level = 8;
      return;
    }
    if(exp < 64000){
      _level = 9;
      return;
    }
    if(exp < 85000){
      _level = 10;
      return;
    }
    if(exp < 100000){
      _level = 11;
      return;
    }
    if(exp < 120000){
      _level = 12;
      return;
    }
    if(exp < 140000){
      _level = 13;
      return;
    }
    if(exp < 165000){
      _level = 14;
      return;
    }
    if(exp < 195000){
      _level = 15;
      return;
    }
    if(exp < 225000){
      _level = 16;
      return;
    }
    if(exp < 265000){
      _level = 17;
      return;
    }
    if(exp < 305000){
      _level = 18;
      return;
    }
    if(exp < 355000){
      _level = 19;
      return;
    }
    _level = 20;
  }

  @override
    String toString() {
      // TODO: implement toString
      return 'this is '+ _name;
    }

}