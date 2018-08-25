import 'package:flutter/material.dart';
import 'package:character_sheet/src/beans/Attributes.dart';
import 'package:character_sheet/src/widgets/AttributeBox.dart';


class AttrWidget extends StatefulWidget{
  AttrWidget({this.attributes});
  final Attributes attributes;
  @override
  createState() => AttrWidgetState(attributes: attributes);
}


class AttrWidgetState extends State<AttrWidget>{
  AttrWidgetState({this.attributes});
  Attributes attributes;

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Attributos',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AttributeBox(attribute: this.attributes.getStrenght(), mod: this.attributes.getStrenghtMod(), title: 'STR'),
                AttributeBox(attribute: this.attributes.getDexterity(), mod: this.attributes.getDexterityMod(), title: 'DEX'),
                AttributeBox(attribute: this.attributes.getConstitution(), mod: this.attributes.getConstitutionMod(), title: 'CON'),
                AttributeBox(attribute: this.attributes.getIntelligence(), mod: this.attributes.getIntelligenceMod(), title: 'INT'),
                AttributeBox(attribute: this.attributes.getWisdom(), mod: this.attributes.getWisdomMod(), title: 'WIS'),
                AttributeBox(attribute: this.attributes.getCharisma(), mod: this.attributes.getCharismaMod(), title: 'CHA'),
              ],
            )
          ],
        ),
      ],
    );
  }
}

// Column(
//               children: <Widget>[
//                 Text('STR')
//               ],
//             ),