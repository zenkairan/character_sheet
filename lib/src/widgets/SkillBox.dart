import 'package:flutter/material.dart';

import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/beans/Skills.dart';
import 'package:character_sheet/src/singletons/SheetSingleton.dart';


class SkillBox extends StatefulWidget{
  SkillBox({@required this.attributes, @required this.level});
  final Attributes attributes;
  final int level;

  @override
  createState() => SkillBoxState(attributes: attributes, level: level);
}

class SkillBoxState extends State<SkillBox>{
  SkillBoxState({@required this.attributes, @required this.level});
  Attributes attributes;
  int level;
  List<SkillList> skills;
  SheetSingleton _sheet = new SheetSingleton();

  @override
  void initState() {
    super.initState();
    _updateAttributes();
  }
  
  @override
  void didUpdateWidget(SkillBox oldWidget) {
      super.didUpdateWidget(oldWidget);
      _updateAttributes();
    }

  void _updateAttributes(){
      this.attributes = _sheet.attributes;
      this.skills = _sheet.skills.skl;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Skills', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
        ] + _skillList(),
      ),
    );
  }

  List<Widget> _skillList(){
    List<Widget> list = new List<Widget>();
    int modValue = attributes.getConstitutionMod();
    bool checked;
    for(int i = 0; i < SkillList.values.length; i ++){
      Skills.skillByAtt.forEach((key, value){
        if(value.contains(SkillList.values[i])){
          switch (key) {
            case AttList.strength:
              modValue = attributes.getStrenghtMod();
              break;
            case AttList.dexterity:
              modValue = attributes.getDexterityMod();
              break;
            case AttList.constitution:
              modValue = attributes.getConstitutionMod();
              break;
            case AttList.intelligence:
              modValue = attributes.getIntelligenceMod();
              break;
            case AttList.wisdom:
              modValue = attributes.getWisdomMod();
              break;
            case AttList.charisma:
              modValue = attributes.getCharismaMod();
              break;
            default:
              modValue = attributes.getConstitutionMod();
              break;
          }
          checked = skills.contains(SkillList.values[i]);
        }
      });
      list.add(_skill(checked,
        checked? (modValue + level).toString() : modValue.toString(), 
        SkillList.values[i].toString().substring(SkillList.values[i].toString().indexOf('.')+ 1).replaceAll('_', ' ')));
    }
    return list;
  }

  Widget _skill(bool checked, String value, String name){
    IconData icon = checked? Icons.radio_button_checked: Icons.radio_button_unchecked; 
    return Row(
      children: <Widget>[
        Icon(icon),
        Container(
          child: Text(value.toString()),
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
        ),
        Text(name,
        style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    );
  }
}