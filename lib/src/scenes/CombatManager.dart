import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:character_sheet/src/singletons/SheetSingleton.dart';

class CombatManager extends StatefulWidget{
  @override
  createState() => CombatManagerState();
}

class CombatManagerState extends State<CombatManager>{

  Life life;

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/life.json');
  }

  Future<File> writeLife(String life) async{
    final file = await _localFile;
    return file.writeAsString('$life');
  }

  Future<String> readLife() async{
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder(
        future: readLife(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            this.life = new Life.fromJSON(json.decode(snapshot.data));
          }else{
            this.life = new Life(0, 0);
          }
          return _manager(context);
        },
      ),
    );
  }

  Widget _manager(BuildContext context){
    return ListView(
      children: <Widget>[
        Text(life.maxHP.toString())
      ],
    );
  }
}

class Life{
  int maxHP;
  int currentHP;

  Life(this.maxHP, this.currentHP);

  Life.fromJSON(Map<String, dynamic> json)
  :maxHP = json['maxHP'],
  currentHP = json['currentHP'];

  Map<String, dynamic> toJson() =>
  {
    'maxHP': maxHP,
    'currentHP': currentHP
  };
}