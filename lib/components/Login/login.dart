import 'package:flutter/material.dart';
import '../Header/index.dart';
import '../Homepage/index.dart';

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
