import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'app_actions.dart';
import 'app_reducer.dart';
import 'app_selectors.dart';
import 'app_state.dart';

import 'components/Login/index.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.loading());

  runApp(FlutterReduxApp(
    title: 'Thermostat',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final String title;
  final Store<AppState> store;

  const FlutterReduxApp({Key key, this.store, this.title}) : super(key: key);

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
