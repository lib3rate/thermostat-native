import 'package:flutter/material.dart';
import '../Login/index.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  void _redirect() {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return LoginPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // padding: const EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: _redirect,
                  child: Image.asset('images/logo.png',
                      width: 100.0, height: 35.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Navigation menu',
                onPressed: () => print('menu got clicked'),
              ),
            ),
          ],
        ));
  }
}
