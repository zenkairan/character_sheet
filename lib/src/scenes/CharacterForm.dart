import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:character_sheet/src/beans/Character.dart';
import 'package:character_sheet/src/singletons/SheetSingleton.dart';

class CharacterForm extends StatefulWidget{
  @override
  createState() => CharacterFormState();
}


class CharacterFormState extends State<CharacterForm>{
  final _formKey = GlobalKey<FormState>();
  Character _character;
  int _selectedClass;
  int _selectedRace;
  int _selectedAlinhamento;
  SheetSingleton _sheet = new SheetSingleton();

  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/character.json');
  }

  Future<File> writeCharacter(String char) async{
    final file = await _localFile;
    return file.writeAsString('$char');
  }

  Future<String> readCharacter() async{
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
        backgroundColor: Colors.blueGrey,
      ),
      body: characterForm(context),
    );
  }

@override
void initState(){
  super.initState();
  if(_sheet.character != null){
    _character = _sheet.character;
    _selectedClass = _character.classe.index;
    _selectedRace = _character.race.index;
    _selectedAlinhamento = _character.alinhamento.index;
  }else{
    _character = new Character();
    _selectedClass = Classes.values.first.index;
    _character.classe = (Classes.values.first);
    _selectedRace = Races.values.first.index;
    _character.race = (Races.values.first);
    _selectedAlinhamento = Alinhamento.values.first.index;
    _character.alinhamento = (Alinhamento.values.first);
  }
}

  Widget characterForm(BuildContext context){
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              initialValue: _character != null? _character.name: '',
              decoration: InputDecoration(
                labelText: 'Nome'
              ),
              validator: (value) {
                if(value.isEmpty)
                  return 'nome é obrigatório';
              },
              onSaved: (value) => _character.name = value,
            ),
            DropdownButton(
              hint: Text('Classe'),
              items: Classes.values.map((Classes value){
                return new DropdownMenuItem(
                  value: value.index,
                  child: Text(value.toString().substring(8)),
                );
              }).toList(),
              value: _selectedClass,
              onChanged: (value){
                _character.classe = (Classes.values[value]);
                setState(() {
                  _selectedClass = value;  
                });
              },
            ),
            DropdownButton(
              hint: Text('Raça'),
              items:  Races.values.map((Races value){
                return new DropdownMenuItem(
                  value: value.index,
                  child: Text(value.toString().substring(6)),
                );
              }).toList(),
              value: _selectedRace,
              onChanged: (value) {
                _character.race = (Races.values[value]);
                setState(() {
                  _selectedRace = value;
                });
              },
            ),
            DropdownButton(
              hint: Text('Alinhamento'),
              items:  Alinhamento.values.map((Alinhamento value){
                return new DropdownMenuItem(
                  value: value.index,
                  child: Text(value.toString().substring(12)),
                );
              }).toList(),
              value: _selectedAlinhamento,
              onChanged: (value) {
                _character.alinhamento = (Alinhamento.values[value]);
                setState(() {
                  _selectedAlinhamento = value;
                });
              },
            ),
            TextFormField(
              initialValue: (_character != null && _character.xp != null)? _character.xp.toString(): '',
              decoration: InputDecoration(labelText: 'Exp.'),
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              validator: (value){
                if(value.isEmpty){
                  return 'Valor obrigatório';
                }
                int valor = int.parse(value, onError: (source) => null);
                if(valor == null || (valor < 1 || valor > 33500)){
                  return 'Experiência deve ser inteira e estar entre 0 e 335.000';
                }
                return null;
              },
              onSaved: (value) => _character.xp = (int.parse(value)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    writeCharacter(json.encode(_character));
                    _sheet.character = _character;
                    Navigator.pop(context);
                  }
                },
                child: Text('Enviar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}