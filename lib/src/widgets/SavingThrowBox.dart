import 'package:flutter/material.dart';

import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/beans/Skills.dart';
import 'package:character_sheet/src/singletons/SheetSingleton.dart';


class SavingThrowBox extends StatefulWidget{

  @override
  createState() => SavingThrowBoxState();
}

class SavingThrowBoxState extends State<SavingThrowBox>{
  Attributes attributes;
  int proficience = 3;
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
      _updateAttributes();
    }
  
  void _updateAttributes(){
      this.attributes = _sheet.attributes;
      // this.proficience = _sheet.character.level;
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
        ] + _getSkills(),
      ),
    );
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


//Widgets não podem ser criados dinamicamente, eles não são removidos depois de criados
  List<Widget> _getSkills(){
    List<Widget> list = new List<Widget>();
    bool checked;
    for(int i = 0; i < AttList.values.length; i++){
      checked = savingThrows.contains(AttList.values[i]);
      list.add(_skill(checked, 
        checked? (attributes.modByIndex(AttList.values[i]) + proficience).toString(): attributes.modByIndex(AttList.values[i]).toString(),
        AttList.values[i].toString().substring(AttList.values[i].toString().indexOf('.')+1).substring(0, 3)));
    }
    return list;
  }
}