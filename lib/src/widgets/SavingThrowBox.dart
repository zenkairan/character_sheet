import 'package:flutter/material.dart';

import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/beans/Skills.dart';
import 'package:character_sheet/src/widgets/SkillWidget.dart';
import 'package:character_sheet/src/singletons/SheetSingleton.dart';


class SavingThrowBox extends StatefulWidget{

  @override
  createState() => SavingThrowBoxState();
}

class SavingThrowBoxState extends State<SavingThrowBox>{
  Attributes attributes;
  int proficience;
  List<AttList> savingThrows;
  SheetSingleton _sheet = new SheetSingleton();

  @override
  void initState() {
    super.initState();
    _updateAttributes();
  }
  
  @override
  void didUpdateWidget(SavingThrowBox oldWidget) {
      super.didUpdateWidget(oldWidget);
      print('updating');
      _updateAttributes();
    }
  
  void _updateAttributes(){
      this.attributes = _sheet.attributes;
      this.proficience = _sheet.character.level;
      this.savingThrows = _sheet.skills.savingThrows;
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
          Text('Saving Throws', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
          // SkillWidget(name: 'str', value: attributes.getStrenghtMod(), checked: true,),
          // SkillWidget(name: 'dex', value: attributes.getDexterityMod(), checked: false,),
          // SkillWidget(name: 'con', value: attributes.getConstitutionMod(), checked: false,),
          // SkillWidget(name: 'int', value: attributes.getIntelligenceMod(), checked: false,),
          // SkillWidget(name: 'wis', value: attributes.getWisdomMod(), checked: false,),
          // SkillWidget(name: 'cha', value: attributes.getCharismaMod(), checked: false,),
        ] + _getSkills(),
      ),
    );
  }

  List<Widget> _getSkills(){
    List<Widget> list = new List<Widget>();
    bool checked;
    //TODO:não está atualizando como attributewidget <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    print(savingThrows);
    for(int i = 0; i < AttList.values.length; i++){
      checked = savingThrows.contains(AttList.values[i]);
      list.add(
        SkillWidget(
          name: AttList.values[i].toString().substring(AttList.values[i].toString().indexOf('.')+1).substring(0, 3), 
          value: checked? attributes.modByIndex(AttList.values[i]) + proficience: attributes.modByIndex(AttList.values[i]), 
          checked: checked)
      );
    }
    return list;
  }
}