import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:character_sheet/src/singletons/SheetSingleton.dart';
import 'package:character_sheet/src/beans/Skills.dart';
import  'package:character_sheet/src/scenes/sheet.dart';

class SkillsForm extends StatefulWidget{
  @override
  createState() => SkillsFormState();
}
class SkillsFormState extends State<SkillsForm>{

  SheetSingleton _sheet = new SheetSingleton();
  Skills _skills;
  bool _expandSaving = false;
  bool _expandSkills = false;

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/skill.json');
  }

  Future<File> writeSkill(String skill) async{
    final file = await _localFile;
    return file.writeAsString('$skill');
  }

  Future<String> readSkill() async{
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  @override
    void initState() {
      super.initState();
      if(_sheet.skills != null){
        _skills = _sheet.skills;
      }
      else{
        _skills = new Skills();
      }
    }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Skills'),
          backgroundColor: Colors.blueGrey,
        ),
        body: skillForm(context),
      );
    }

    Widget skillForm(BuildContext context){
      return SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              ExpansionPanelList(
                expansionCallback: (int panelIndex, bool isExpanded){
                  setState(() {
                    switch (panelIndex) {
                      case 0:
                        _expandSaving = !_expandSaving;
                        break;
                      case 1:
                        _expandSkills = !_expandSkills;
                        break;
                    }
                  });
                },
                children: <ExpansionPanel> [
                  ExpansionPanel(
                    isExpanded: _expandSaving,
                    body: Column(
                      children: getSavingThrows(),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return ListTile(
                        title: Text('Saving Throws'),
                        onTap: (){
                          setState(() {
                            _expandSaving = !_expandSaving;
                          });
                        },
                      );
                    }
                  ),
                  ExpansionPanel(
                    isExpanded: _expandSkills,
                    body: Column(
                      children: getSkills(),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return ListTile(
                        title: Text('Saving Throws'),
                        onTap: (){
                          setState(() {
                            _expandSkills = !_expandSkills;
                          });
                        },
                      );
                    }
                  ),
                ],
              ),
              Center(
                child: RaisedButton(
                  onPressed: (){
                    writeSkill(json.encode(_skills));
                    _sheet.skills = _skills;
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new Sheet()
                    ));
                  },
                  child: Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> getSavingThrows(){
      List<Widget> savings = new List<Widget>();
      for(int i = 0; i < AttList.values.length; i++){
        savings.add(
          CheckboxListTile(
            value: _skills.savingThrows.isEmpty || !_skills.savingThrows.contains(AttList.values[i])? false: true,
            onChanged: (value) {
              setState(() {
                if(value){
                  _skills.savingThrows.add(AttList.values[i]);
                }
                else{
                  _skills.savingThrows.remove(AttList.values[i]);
                }
              });
            },
            title: Text(AttList.values[i].toString().substring(AttList.values[i].toString().indexOf('.')+1).replaceAll('_', ' ')),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.amberAccent,
          ),
        );
      }
      return savings;
    }

    List<Widget> getSkills(){
      List<Widget> skillList = new List<Widget>();
      for(int i = 0; i < SkillList.values.length; i++){
        skillList.add(
          CheckboxListTile(
            value: _skills.skl.isEmpty || !_skills.skl.contains(SkillList.values[i])? false: true,
            onChanged: (value){
              setState(() {
                if(value){
                  _skills.skl.add(SkillList.values[i]);
                }
                else{
                  _skills.skl.remove(SkillList.values[i]);
                }
              });
            },
            title: Text(SkillList.values[i].toString().substring(SkillList.values[i].toString().indexOf('.')+1).replaceAll('_', ' ')),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: Colors.greenAccent,
          )
        );
      }
      return skillList;
    }

}