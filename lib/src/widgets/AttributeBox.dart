import 'package:flutter/material.dart';

class AttributeBox extends StatefulWidget{
  AttributeBox({@required this.attribute, @required this.mod, @required this.title});
  final int attribute;
  final int mod;
  final String title;

  @override
  createState() => AttributeBoxState(attribute: attribute, mod: mod, title: title);
}

class AttributeBoxState extends State<AttributeBox>{
  AttributeBoxState({@required this.attribute, @required this.mod, @required this.title});
  int attribute;
  int mod;
  String title;

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
                Text(this.title),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(this.attribute.toString()),
                ),
                Text(
                  this.mod.toString(),
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  )
              ],
            ),
          );
  }
}