import 'package:flutter/material.dart';
import 'package:character_sheet/src/scenes/CharacterForm.dart';
import 'package:character_sheet/src/scenes/profile.dart';
import 'package:character_sheet/src/scenes/sheet.dart';
import 'package:character_sheet/src/scenes/SkillsForm.dart';

// final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main(){
  runApp(
    new MaterialApp(
      home: new Sheet(),
      routes: <String, WidgetBuilder>{
        '/character': (BuildContext context) => new CharacterForm(),
        '/sheet': (BuildContext context) => new Sheet(),
        '/attributes': (BuildContext context) => new Profile(),
        '/skills': (BuildContext context) => new SkillsForm(),
      },
      // navigatorObservers: [routeObserver],
    )
  );
}

//focus on menu and navigation now



