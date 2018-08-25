import 'package:flutter/material.dart';
import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/widgets/SkillWidget.dart';


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
          SkillWidget(name: 'Acrobatics', value: attributes.getDexterityMod(), checked: false,),
          SkillWidget(name: 'Animal Handling', value: attributes.getWisdomMod(), checked: false,),
          SkillWidget(name: 'Arcana', value: attributes.getIntelligenceMod(), checked: false,),
          SkillWidget(name: 'Athetics', value: attributes.getStrenghtMod(), checked: false,),
          SkillWidget(name: 'Deception', value: attributes.getCharismaMod(), checked: false,),
          SkillWidget(name: 'History', value: attributes.getIntelligenceMod(), checked: false,),
          SkillWidget(name: 'Insight', value: attributes.getWisdomMod(), checked: false,),
          SkillWidget(name: 'Intimidation', value: attributes.getCharismaMod(), checked: false,),
          SkillWidget(name: 'Investigation', value: attributes.getIntelligenceMod(), checked: false,),
          SkillWidget(name: 'Medicine', value: attributes.getWisdomMod(), checked: false,),
          SkillWidget(name: 'Nature', value: attributes.getIntelligenceMod(), checked: false,),
          SkillWidget(name: 'Perception', value: attributes.getWisdomMod(), checked: false,),
          SkillWidget(name: 'Performance', value: attributes.getCharismaMod(), checked: false,),
          SkillWidget(name: 'Persuasion', value: attributes.getCharismaMod(), checked: false,),
          SkillWidget(name: 'Religion', value: attributes.getIntelligenceMod(), checked: false,),
          SkillWidget(name: 'Sleight of Hand', value: attributes.getDexterityMod(), checked: false,),
          SkillWidget(name: 'Stealth', value: attributes.getDexterityMod(), checked: false,),
          SkillWidget(name: 'Survival', value: attributes.getWisdomMod(), checked: false,),
        ],
      ),
    );
  }
}