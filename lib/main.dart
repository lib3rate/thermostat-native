import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thermostat',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: Header(),
    //   body: Center(
    //     child: LoginForm(),
    //   ),
    // );
    return Material(
        child: Column(children: <Widget>[
      Header(),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: LoginForm(),
        ),
      ),
    ]));
  }
}

class LoginForm extends StatefulWidget {
  final Function login = () {};

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _login() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return HomePage(title: 'Thermostat Home');
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username'),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your password'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                _login();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

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
