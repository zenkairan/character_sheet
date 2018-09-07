import 'package:flutter/material.dart';

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
                    child: Image.network(
                            'https://cdn2.bigcommerce.com/server4900/364bb/products/150000/images/109252/195771__19255.1342531738.380.500.jpg?c=2',
                            alignment: Alignment(-0.00, 0.00),
                            height: 120.00,
                            width: 120.00,
                            fit: BoxFit.contain ,
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

}