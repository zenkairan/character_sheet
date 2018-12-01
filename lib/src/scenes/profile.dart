import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/scenes/sheet.dart';
import  'package:path_provider/path_provider.dart';
import 'package:character_sheet/src/singletons/SheetSingleton.dart';

class Profile extends StatefulWidget{
  @override
  createState() => ProfileState();
}

class ProfileState extends State<Profile>{
  final _formKey = GlobalKey<FormState>();

  Attributes _attributes = new Attributes();
  SheetSingleton _sheet = new SheetSingleton();
  //TODO: provavelmente não vai precisar buscar arquivo
  
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/attributes.json');
  }

  Future<File> writeAttributes(String att) async{
    final file = await _localFile;
    return file.writeAsString('$att');
  }

  Future<String> readAttributes() async{
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState(){
    super.initState();
    if(_sheet.attributes != null){
      _attributes = _sheet.attributes;
    }
    // readAttributes().then((String value){
    //   if(value == null){
    //     return;
    //   }
    //   _attributes = new Attributes.fromJson(json.decode(value));
    //   Navigator.push(context, new MaterialPageRoute(
    //     builder: (BuildContext context) => new Sheet()
    //   ));
    // });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _attributesForm(context),
    );
  }

  Widget _attributesForm(BuildContext context){
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              initialValue: _attributes != null? _attributes.strength.toString(): null,
              decoration: InputDecoration(
                labelText: 'Força (STR)',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                )
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              validator: (value) {
                return _validar(value);
                
              },
              onSaved: (value) => _attributes.strength = (int.parse(value)),
            ),
            TextFormField(
              initialValue: _attributes != null? _attributes.dexterity.toString(): null,
              decoration: InputDecoration(
                labelText: 'Destreza (DEX)',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                )
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              validator: (value) {
                return _validar(value);
              },
              onSaved: (value) => _attributes.dexterity = (int.parse(value)),
            ),
            TextFormField(
              initialValue: _attributes != null? _attributes.constitution.toString(): null,
              decoration: InputDecoration(
                labelText: 'Constituição (CON)',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                )
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              validator: (value) {
                return _validar(value);
                
              },
              onSaved: (value) => _attributes.constitution =(int.parse(value)),
            ),
            TextFormField(
              initialValue: _attributes != null? _attributes.intelligence.toString(): null,
              decoration: InputDecoration(
                labelText: 'Inteligência (INT)',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                )
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              validator: (value) {
                return _validar(value);
                
              },
              onSaved: (value) => _attributes.intelligence = (int.parse(value)),
            ),
            TextFormField(
              initialValue: _attributes != null? _attributes.wisdom.toString(): null,
              decoration: InputDecoration(
                labelText: 'Sabedoria (WIS)',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                )
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              validator: (value) {
                return _validar(value);
                
              },
              onSaved: (value) => _attributes.wisdom = (int.parse(value)),
            ),
            TextFormField(
              initialValue: _attributes != null? _attributes.charisma.toString(): null,
              decoration: InputDecoration(
                labelText: 'Carisma (CHA)',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber
                )
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
              validator: (value) {
                return _validar(value);
                
              },
              onSaved: (value) => _attributes.charisma = (int.parse(value)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    writeAttributes(json.encode(_attributes));
                    _sheet.attributes = _attributes;
                    if(_sheet.skills == null){
                      Navigator.of(context).pushNamed('/skills');
                    }else{
                      Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => new Sheet()
                      ));
                    }
                  }
                },
                child: Text('Enviar'),
              ),
            ),
          ],
        ) 
      ),
    );
  }

  _validar(value){
    if(value.isEmpty){
      return 'Valor obrigatório';
    }
    int valor = int.parse(value, onError: (source) => null);
    if(valor == null || (valor < 1 || valor > 20)){
      return 'Attributos devem ser inteiros e estar entre 1 e 20';
    }
    return null;
  }
}