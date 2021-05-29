import 'package:flutter/material.dart';
import '../Header/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 20;

  void _increaseDesiredTemperature() {
    setState(() => _counter++);
  }

  void _decreaseDesiredTemperature() {
    setState(() => _counter--);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _increaseDesiredTemperature method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Desired temperature:',
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              FloatingActionButton(
                onPressed: _decreaseDesiredTemperature,
                tooltip: 'Decrease desired temperature',
                child: Icon(Icons.remove),
                heroTag: "decrease temperature button",
              ),
              Text(
                '$_counter°',
                style: Theme.of(context).textTheme.headline4,
              ),
              FloatingActionButton(
                onPressed: _increaseDesiredTemperature,
                tooltip: 'Increase desired temperature',
                child: Icon(Icons.add),
                heroTag: "increase temperature button",
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
