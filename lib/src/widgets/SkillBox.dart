import 'package:flutter/material.dart';

import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/widgets/SkillWidget.dart';
import 'package:character_sheet/src/beans/Skills.dart';


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
        }
      });
      list.add(SkillWidget(name: SkillList.values[i].toString().substring(SkillList.values[i].toString().indexOf('.')+ 1).replaceAll('_', ' '), value: modValue, checked: false,));
    }
    return list;
  }
}