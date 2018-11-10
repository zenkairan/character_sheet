import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import 'package:character_sheet/src/beans/Character.dart';
import 'package:character_sheet/src/singletons/SheetSingleton.dart';

class CharacterBox extends StatefulWidget{
  CharacterBox({@required this.character});
  final Character character;

  @override
  createState() => CharacterBoxState(character: character);
}

class CharacterBoxState extends State<CharacterBox>{
  CharacterBoxState({@required this.character});
  Character character;
  SheetSingleton _sheet = new SheetSingleton();

  Image _imagem = Image.asset(
                        'assets/blank_portrait.jpg',
                        alignment: Alignment(-0.00, 0.00),
                        height: 120.00,
                        width: 120.00,
                        fit: BoxFit.contain ,
                        );

  Future getImage(ImageSource source) async{
    File image = await ImagePicker.pickImage(source: source,);
    final path = await _localPath;
    File copyImage = await image.copy('$path/prifilepic.jpg');
    if(source == ImageSource.camera){
      await image.delete();
    }
    setState(() {
      _imagem = Image.file(copyImage,
                        alignment: Alignment(-0.00, 0.00),
                        height: 120.00,
                        width: 120.00,
                        fit: BoxFit.contain 
                    );
    });
  }

  //file
  Future<String> get _localPath async{
    //external só funciona em android <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _imageFile async{
    final path = await _localPath;
    return File('$path/prifilepic.jpg');
  }

  Future<File> readData() async{
    try {
      File imageFile = await _imageFile;
      return imageFile;
    } catch (e) {
      print(e);
      return null;
    }
  }
  
  @override
    void didUpdateWidget(CharacterBox oldWidget) {
      super.didUpdateWidget(oldWidget);
      character = _sheet.character;
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
        children: <Widget>[
          Row(
            // textDirection: TextDirection.rtl,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(character.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                    ),
                    Text('Level: ' + character.level.toString()),
                    Text('Classe: ' + character.classe.toString().substring(8)),
                    Text('Raça: ' + character.race.toString().substring(6)),
                    Text('XP: ' + character.xp.toString()),
                    Text('Alinhamento: ' + character.alinhamento.toString().substring(12))
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                    padding: const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 1.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FutureBuilder(
                      future: readData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        if(snapshot.hasData && snapshot.data != null){
                          _imagem = Image.file(snapshot.data,
                                alignment: Alignment(-0.00, 0.00),
                                height: 120.00,
                                width: 120.00,
                                fit: BoxFit.contain 
                            );
                          return FlatButton(
                            child: _imagem,
                            onPressed: (){
                              _dialog(context);
                            },
                          );
                        }else{
                          return new Center(
                            child: new CircularProgressIndicator(),
                          ); 
                        }

                      },
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future _dialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Galeria'),
              onPressed: (){
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              }
            ),
            SimpleDialogOption(
              child: Text('Câmera'),
              onPressed: (){
                getImage(ImageSource.camera);
                Navigator.pop(context);
              }
            )
          ],
        );
      }
    ); 
    
    
  }

}