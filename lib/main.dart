import 'package:flutter/material.dart';
import 'package:character_sheet/src/scenes/CharacterForm.dart';
import 'package:character_sheet/src/scenes/profile.dart';
import 'package:character_sheet/src/scenes/sheet.dart';

final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main(){
  runApp(
    new MaterialApp(
      home: new Sheet(routeObserver: routeObserver,),
      routes: <String, WidgetBuilder>{
        '/character': (BuildContext context) => new CharacterForm(),
        // '/profile': (BuildContext context) => new Profile(),
        '/sheet': (BuildContext context) => new Sheet(routeObserver: routeObserver,),
      },
      navigatorObservers: [routeObserver],
    )
  );
}

//focus on menu and navigation now



