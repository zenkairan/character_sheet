import 'package:flutter/material.dart';
import 'package:character_sheet/src/scenes/CharacterForm.dart';

class MainDrower extends StatefulWidget{

  @override
  createState() => MainDrowerState();
}

class MainDrowerState extends State<MainDrower>{

  @override
  Widget build(BuildContext context){
    return Drawer(
        child: ListView(
          children: <Widget>[
            FlatButton(
              child: Text('Edit Character'),
              onPressed: () => Navigator.pushNamed(context, '/character')
            ),
          ],
        ),
      );
  }
}