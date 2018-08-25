import 'package:flutter/material.dart';
import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/widgets/SkillWidget.dart';


class SavingThrowBox extends StatefulWidget{
  SavingThrowBox({@required this.attributes, @required this.level});
  final Attributes attributes;
  final int level;

  @override
  createState() => SavingThrowBoxState(attributes: attributes, level: level);
}

class SavingThrowBoxState extends State<SavingThrowBox>{
  SavingThrowBoxState({@required this.attributes, @required this.level});
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
          Text('Saving Throws', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
          SkillWidget(name: 'str', value: attributes.getStrenghtMod(), checked: true,),
          SkillWidget(name: 'dex', value: attributes.getDexterityMod(), checked: false,),
          SkillWidget(name: 'con', value: attributes.getConstitutionMod(), checked: false,),
          SkillWidget(name: 'int', value: attributes.getIntelligenceMod(), checked: false,),
          SkillWidget(name: 'wis', value: attributes.getWisdomMod(), checked: false,),
          SkillWidget(name: 'cha', value: attributes.getCharismaMod(), checked: false,),
        ],
      ),
    );
  }
}