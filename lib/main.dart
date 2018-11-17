import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:character_sheet/src/scenes/CharacterForm.dart';
import 'package:character_sheet/src/scenes/profile.dart';
import 'package:character_sheet/src/scenes/sheet.dart';
import 'package:character_sheet/src/scenes/SkillsForm.dart';
import 'package:character_sheet/src/scenes/CombatManager.dart';

// final RouteObserver<PageRoute> routeObserver = new RouteObserver<PageRoute>();
void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) //orientation lock
  .then((_) {
    runApp(
      new MaterialApp(
        home: new Sheet(),
        routes: <String, WidgetBuilder>{
          '/character': (BuildContext context) => new CharacterForm(),
          '/sheet': (BuildContext context) => new Sheet(),
          '/attributes': (BuildContext context) => new Profile(),
          '/skills': (BuildContext context) => new SkillsForm(),
          '/combatManager': (BuildContext context) => new CombatManager()
        },
        // navigatorObservers: [routeObserver],
      )
    );
  });
}

//focus on menu and navigation now



