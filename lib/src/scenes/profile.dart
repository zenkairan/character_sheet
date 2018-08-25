import 'package:flutter/material.dart';
import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/beans/Character.dart';
import 'package:character_sheet/src/scenes/sheet.dart';
import  'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Profile extends StatefulWidget{
  Profile({@required this.character});
  final Character character;
  @override
  createState() => ProfileState(character: character);
}

class ProfileState extends State<Profile>{
  ProfileState({@required this.character});
  Character character;
  final _formKey = GlobalKey<FormState>();
  Attributes _attributes = new Attributes();
  
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
    readAttributes().then((String value){
      if(value == null){
        return;
      }
      _attributes = new Attributes.fromJson(json.decode(value));
      print(_attributes);
      Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => new Sheet(attributes: _attributes, character: character,)
      ));
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
              onSaved: (value) => _attributes.setStrength(int.parse(value)),
            ),
            TextFormField(
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
              onSaved: (value) => _attributes.setDexterity(int.parse(value)),
            ),
            TextFormField(
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
              onSaved: (value) => _attributes.setConstitution(int.parse(value)),
            ),
            TextFormField(
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
              onSaved: (value) => _attributes.setIntelligence(int.parse(value)),
            ),
            TextFormField(
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
              onSaved: (value) => _attributes.setWisdom(int.parse(value)),
            ),
            TextFormField(
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
              onSaved: (value) => _attributes.setCharisma(int.parse(value)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    debugPrint(_attributes.getStrenght().toString());
                    //TEM ALGUM PROBLEMA COM CONTEXT
                    // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Validando'),));
                    writeAttributes(json.encode(_attributes));
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => new Sheet(attributes: _attributes, character: character,)
                    ));
                    // Navigator.of(context).pushNamed('/sheet');
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