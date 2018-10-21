import 'package:flutter/material.dart';

class ProficienceBox extends StatefulWidget{
  ProficienceBox({@required this.level});
  final int level;

  @override
  createState() => ProficienceBoxState(level: level);
}

class ProficienceBoxState extends State<ProficienceBox>{
  ProficienceBoxState({@required this.level});
  int level;

  @override
  Widget build(BuildContext context){
    return Container(
            margin: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
            padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                  padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                        padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                         child: Text(level.toString()),
                      ),
                      Text('Inspiração')
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                  padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                        padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                         child: Text('3'),
                      ),
                      Text('Proficiência')
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}