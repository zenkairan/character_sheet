import 'package:character_sheet/src/singletons/SheetSingleton.dart';
import 'package:flutter/material.dart';
import 'package:character_sheet/src/beans/Character.dart';
import 'package:character_sheet/src/scenes/profile.dart';
import  'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

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
      ),
      body: characterForm(context),
    );
  }

@override
void initState(){
  super.initState();
  _sheet = new SheetSingleton();
  if(_sheet.character != null){
    _character = _sheet.character;
    _selectedClass = _character.getClasse().index;
    _selectedRace = _character.getRace().index;
    _selectedAlinhamento = _character.getAlinhamento().index;
  }else{
    _character = new Character();
    _selectedClass = Classes.values.first.index;
    _character.setClasse(Classes.values.first);
    _selectedRace = Races.values.first.index;
    _character.setRace(Races.values.first);
    _selectedAlinhamento = Alinhamento.values.first.index;
    _character.setAlinhamento(Alinhamento.values.first);
  }
  // readCharacter().then((String value){
  //     if(value == null){
  //       return;
  //     }
  //     _character = new Character.fromJson(json.decode(value));
  //     print(_character);
  //     Navigator.push(context, new MaterialPageRoute(
  //       builder: (BuildContext context) => new Profile(character: _character,)
  //     ));
  //   });
}

  Widget characterForm(BuildContext context){
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              initialValue: _character != null? _character.getNome(): '',
              decoration: InputDecoration(
                labelText: 'Nome'
              ),
              validator: (value) {
                if(value.isEmpty)
                  return 'nome é obrigatório';
              },
              onSaved: (value) => _character.setName(value),
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
                _character.setClasse(Classes.values[value]);
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
                _character.setRace(Races.values[value]);
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
                _character.setAlinhamento(Alinhamento.values[value]);
                setState(() {
                  _selectedAlinhamento = value;
                });
              },
            ),
            TextFormField(
              initialValue: _character != null? _character.getXp().toString(): '',
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
              onSaved: (value) => _character.setXp(int.parse(value)),
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