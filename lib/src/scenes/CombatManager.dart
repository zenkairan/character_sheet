import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class CombatManager extends StatefulWidget{
  @override
  createState() => CombatManagerState();
}

class CombatManagerState extends State<CombatManager>{

  Life life;
  int _maxHP = 0;
  int _currentHP = 0;
  final _formKey = GlobalKey<FormState>();
  final _damageKey = GlobalKey<FormState>();
  BuildContext _outerContext;

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
        title: Text('Combate'),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: readLife(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            this.life = new Life.fromJSON(json.decode(snapshot.data));
            _currentHP = life.currentHP;
            _maxHP = life.maxHP;
          }else{
            this.life = new Life(0, 0);
          }
          //não sei porque outerContext funciona e o normal não, mas vai ficar assim
          _outerContext = context;
          return _manager(context);
        },
      ),
    );
  }

  Widget _manager(BuildContext context){
    return ListView(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
          padding: const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 1.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                      padding: const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 1.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Max HP',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          Text(
                            _maxHP.toString(),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    onPressed: () => _maxHPDialog(context),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        iconSize: 50.0,
                        onPressed: () => _damageDialog(false, context),
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'HP',
                            style: TextStyle(fontSize:20.0),
                          ),
                          Text(
                            _currentHP.toString(),
                            style: TextStyle(fontSize: 50.0),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 50.0,
                        onPressed: () => _damageDialog(true, context),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ),
      ],
    );
  }

  Future _maxHPDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _maxHP.toString(),
                    decoration: InputDecoration(labelText: 'Max HP'),
                    keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                    validator: (value) {
                      if(value.isEmpty)
                        return 'Valor obrigatório';
                    },
                    onSaved: (value) {
                      setState(() {
                        life.maxHP = int.parse(value);
                        _maxHP = life.maxHP;
                        if(_currentHP == 0){
                          _currentHP = _maxHP;
                          life.currentHP = _currentHP;
                        }
                        writeLife(json.encode(life));
                      });
                    } ,
                  ),
                  RaisedButton(
                     child: Text('Salvar'),
                     onPressed: (){
                       if(_formKey.currentState.validate()){
                         _formKey.currentState.save();
                         Navigator.pop(context);
                       }
                     },
                  )
                ],
              ),
            )
          ],
        );
      }
    );
  }

  Future _damageDialog(bool operation, BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          children: <Widget>[
            Form(
              key: _damageKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: operation? 'Cura': 'Dano'),
                    keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                    validator: (value){
                      if(value.isEmpty)
                        return 'Valor obrigatório';
                    },
                    onSaved: (value){
                      int valor = int.parse(value);
                      setState(() {
                        if(operation){
                          _currentHP += valor;
                          if(_currentHP > _maxHP)
                            _currentHP = _maxHP;
                        }else{
                          _currentHP -= valor;
                        }
                        life.currentHP = _currentHP;
                        writeLife(json.encode(life));
                      }); 
                      if(!operation && (_maxHP <= 0 || valor >= (_maxHP/2).round())){
                        String msg;
                        if(valor >= (_maxHP/2).round()){
                          msg = 'DERRUBADO: dano maior que metade da vida máxima';
                        }
                        if(_currentHP <= 0){
                          msg = 'DERRUBADO: vida menor ou igual a 0';
                        }
                        Scaffold.of(_outerContext).showSnackBar(SnackBar(
                          content: Text(msg),
                          )
                        );
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text('Salvar'),
                     onPressed: (){
                       if(_damageKey.currentState.validate()){
                         _damageKey.currentState.save();
                         Navigator.pop(context);
                       }
                     },
                  ),
                ],
              ),
            ),
          ],
        );
      },
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