import 'package:flutter/material.dart';

class SkillWidget extends StatefulWidget{
  SkillWidget({@required this.name, @required this.value, @required this.checked});
  final int value;
  final String name;
  final bool checked;

  @override
  createState() => SkillWidgetState(name: name, value: value, checked: checked);
}

class SkillWidgetState extends State<SkillWidget>{
  SkillWidgetState({@required this.name, @required this.value, @required this.checked});
  int value;
  String name;
  bool checked;

  @override
  Widget build(BuildContext context){
    IconData icon = checked? Icons.radio_button_checked: Icons.radio_button_unchecked; 
    return Row(
            children: <Widget>[
              Icon(icon),
              Text('__'+ value.toString() +'__' + name,)
            ],
          );
  }
}