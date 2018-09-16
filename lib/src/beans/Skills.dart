
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
  List<SkillList> skl;
  static final Map<AttList, List<SkillList>> skillByAtt = {
    AttList.strength : [SkillList.Athetics],
    AttList.dexterity : [SkillList.Acrobatics, SkillList.Sleight_of_Hand, SkillList.Stealth],
    AttList.constitution : [],
    AttList.intelligence : [SkillList.Arcana, SkillList.History, SkillList.Investigation, SkillList.Nature, SkillList.Religion],
    AttList.wisdom : [SkillList.Animal_handling, SkillList.Insight, SkillList.Medicine, SkillList.Perception, SkillList.Survival],
    AttList.charisma : [SkillList.Deception, SkillList.Intimidation, SkillList.Performance, SkillList.Persuasion]
  };

  Skills(){
    savingThrows = new List<AttList>();
    skl = new List<SkillList>();
  }
  
  Skills.fromJson(Map<String, dynamic> json){
  savingThrows = _deserializeSavingThrows(json['savingThrows']);
  skl = _deserializeSkills(json['skl']);
  }

  Map<String, dynamic> toJson() =>
  {
    'savingThrows' : _serializeSavingThrows(),
    'skl' : _serializeSkills()
  };

  List<int> _serializeSavingThrows(){
    List<int> savings = new List<int>();
    for(int i = 0; i < savingThrows.length; i++){
      savings.add(savingThrows[i].index);
    }
    return savings;
  }
  List<int> _serializeSkills(){
    List<int> skillList = new List<int>();
    for(int i = 0; i < skl.length; i++){
      skillList.add(skl[i].index);
    }
    return skillList;
  }
  List<AttList> _deserializeSavingThrows(List jsonList){
    List<AttList> savings = new List<AttList>();
    for(int i = 0; i < jsonList.length; i++){
      savings.add(AttList.values[jsonList[i]]);
    }
    return savings;
  }
  List<SkillList> _deserializeSkills(List jsonList){
    List<SkillList> skillList = new List<SkillList>();
    for(int i = 0; i < jsonList.length; i++){
      skillList.add(SkillList.values[jsonList[i]]);
    }
    return skillList;
  }
}