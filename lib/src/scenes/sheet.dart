import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:character_sheet/src/singletons/SheetSingleton.dart';
import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/beans/Character.dart';
import 'package:character_sheet/src/beans/Skills.dart';
import 'package:character_sheet/src/widgets/AttrWidget.dart';
import 'package:character_sheet/src/widgets/CharacterBox.dart';
import 'package:character_sheet/src/widgets/ProficienceBox.dart';
import 'package:character_sheet/src/widgets/SavingThrowBox.dart';
import 'package:character_sheet/src/widgets/SkillBox.dart';
import 'package:character_sheet/src/widgets/MainDrawer.dart';


class Sheet extends StatefulWidget{
  // Sheet({this.routeObserver});
  // final routeObserver;
  @override
  createState() => SheetState();
}

class SheetState extends State<Sheet> with RouteAware{
  // SheetState({this.routeObserver});
  Attributes attributes;
  Character character;
  Skills skills;
  SheetSingleton _sheet = new SheetSingleton();
  // RouteObserver<PageRoute> routeObserver;
  final GlobalKey<ScaffoldState> _sheetKey = new GlobalKey<ScaffoldState>();
  /*TODO:
   * tornar sheet a pagina inicial sem obrigatoriedades.
   * criar loading para os arquivos asincronos
   */

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _characterFile async{
    final path = await _localPath;
    return File('$path/character.json');
  }
  Future<File> get _attributesFile async{
    final path = await _localPath;
    return File('$path/attributes.json');
  }
  Future<File> get _skillsFile async{
    final path = await _localPath;
    return File('$path/skill.json');
  }
  Future<List> readData() async{
    //TODO: explode erro quando ainda não há arquivos e nada carrega!!!!!!!
    try {
      final characterFile = await _characterFile;
      final attributesFile = await _attributesFile;
      final skillsFile = await _skillsFile;
      String character = await characterFile.readAsString();
      String attributes = await attributesFile.readAsString();
      String skills = await skillsFile.readAsString();
      return [character,attributes, skills];
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _sheetKey,
      appBar: AppBar(
        title: Text('Ficha'),
      ),
      body: FutureBuilder(
        future: readData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data != null){
              this.character = new Character.fromJson(json.decode(snapshot.data[0]));
              _sheet.character = this.character;
              this.attributes = new Attributes.fromJson(json.decode(snapshot.data[1]));
              _sheet.attributes = this.attributes;
              this.skills = new Skills.fromJson(json.decode(snapshot.data[2]));
              _sheet.skills = this.skills;
              return _renderSheet(context);
            }
          }else{
            return new Center(
              child: new CircularProgressIndicator(),
            ); 
            
          }
        },
      ),
      drawer: MainDrower()
    );
  }

  Widget _renderSheet(BuildContext context){
    return ListView(
        children: <Widget>[
          CharacterBox(character: character,),
          Row(
            children: <Widget>[
              AttrWidget(attributes: this.attributes),
              Column(
                children: <Widget>[
                  ProficienceBox(level: character.level),
                  SavingThrowBox(),
                  SkillBox(attributes: attributes, level: character.level,),
                ],
              ),
            ],
          ),
        ],
      );
  }
}