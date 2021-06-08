import 'package:flutter/material.dart';

class DrawerComponent extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<DrawerComponent> {
  var units = [
    'Unit 100',
    'Unit 200',
    'Unit 400',
    'Unit 500',
    'Unit 600',
    'Unit 700',
    'Unit 800',
    'Unit 900',
    'Unit 1000',
    'Unit 1100',
    'Unit 1200'
  ];

  List<Widget> buildUnits() {
    return units
        .map((unit) => ListTile(
              title: Text(unit),
              onTap: () {
                Navigator.pop(context);
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text('Building Units (${units.length})')),
          Column(children: buildUnits()),
          // Column(children: units.map((unit) => ListTile(title: Text(unit))).toList()),
        ],
      ),
    );
  }
}
