
enum SkillList{
  Acrobatics,
  Animal_handling,
  Arcana,
  Athetics,
  Deception,
  History,
  Insight,
  Intimidation,
  Investigation,
  Medicine,
  Nature,
  Perception,
  Performance,
  Persuasion,
  Religion,
  Sleight_of_Hand,
  Stealth,
  Survival
}

enum AttList{
  strength,
  dexterity,
  constitution,
  intelligence,
  wisdom,
  charisma,
}

class Skills{
  List<AttList> savingThrows;
  List<SkillList> att;
  static final Map<AttList, List<SkillList>> skillByAtt = {
    AttList.strength : [SkillList.Athetics],
    AttList.dexterity : [SkillList.Acrobatics, SkillList.Sleight_of_Hand, SkillList.Stealth],
    AttList.constitution : [],
    AttList.intelligence : [SkillList.Arcana, SkillList.History, SkillList.Investigation, SkillList.Nature, SkillList.Religion],
    AttList.wisdom : [SkillList.Animal_handling, SkillList.Insight, SkillList.Medicine, SkillList.Perception, SkillList.Survival],
    AttList.charisma : [SkillList.Deception, SkillList.Intimidation, SkillList.Performance, SkillList.Persuasion]
  };

  Skills();
  
  Skills.fromJson(Map<String, dynamic> json)
  :savingThrows = json['savingThrows'],
  att = json['att'];

  Map<String, dynamic> toJson() =>
  {
    'savingThrows' : savingThrows,
    'att' : att
  };
}