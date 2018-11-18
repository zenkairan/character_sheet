import 'package:flutter/material.dart';

class MainDrower extends StatefulWidget{

  @override
  createState() => MainDrowerState();
}

class MainDrowerState extends State<MainDrower>{

  @override
  Widget build(BuildContext context){
    return Drawer(
        child: Container(
          color: Colors.black12,
          child: ListView(
            children: <Widget>[
              FlatButton(
                child: Text('Edit Character'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/character');
                  }
              ),
              Divider(
                color: Colors.black,
                height: 5,
              ),
              FlatButton(
                child: Text('Edit Attributes'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/attributes');
                  }
              ),
              Divider(
                color: Colors.black,
                height: 5,
              ),
              FlatButton(
                child: Text('Edit Skills'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/skills');
                  }
              ),
              Divider(
                color: Colors.black,
                height: 5,
              ),
              FlatButton(
                child: Text('Combat'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/combatManager');
                  }
              ),
              Divider(
                color: Colors.black,
                height: 5,
              ),
            ],
          ),
        )
      );
  }
}