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
    'Unit 300',
    'Unit 400',
    'Unit 500',
    'Unit 600',
    'Unit 700',
    'Unit 800',
    'Unit 900',
    'Unit 1000'
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
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Building Units (${units.length})',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Column(children: buildUnits()),
        ],
      ),
    );
  }
}
