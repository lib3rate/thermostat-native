import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Header/index.dart';
import '../Drawer/index.dart';

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
  int _desiredTemperature = 25;

  late Future<TemperatureData> outdoorTemperatureData;

  void _increaseDesiredTemperature() {
    setState(() => _desiredTemperature++);
  }

  void _decreaseDesiredTemperature() {
    setState(() => _desiredTemperature--);
  }

  @override
  void initState() {
    super.initState();
    outdoorTemperatureData = fetchOutdoorTemperature();
  }

  Future<TemperatureData> fetchOutdoorTemperature() async {
    DateTime currentTimestamp = DateTime.now();
    DateTime previousTimestamp =
        currentTimestamp.subtract(const Duration(minutes: 17));

    final response = await http.get(Uri.parse(
        'https://api-staging.paritygo.com/sensors/api/sensors/outdoor-1/?begin=${previousTimestamp}&end=${currentTimestamp}'));

    if (response.statusCode == 200) {
      var temperature = TemperatureData.fromJson(jsonDecode(response.body))
          .averageTemperature;
      setState(() => _desiredTemperature = temperature);
      return TemperatureData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load the temperature data');
    }
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          StoreConnector<int, String>(
            converter: (store) => store.state.selectedUnit.toString(),
            builder: (context, selectedUnit) {
              return Text(
                'Unit $selectedUnit',
                style: Theme.of(context).textTheme.headline5,
              );
            },
          ),
          Column(
            children: <Widget>[
              Text(
                'Outdoor temperature:',
                style: Theme.of(context).textTheme.headline5,
              ),
              FutureBuilder<TemperatureData>(
                future: outdoorTemperatureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data!.averageTemperature}°C",
                        style: Theme.of(context).textTheme.headline4);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
              Text(
                'Desired temperature:',
                style: Theme.of(context).textTheme.headline5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                FloatingActionButton(
                  mini: true,
                  onPressed: _decreaseDesiredTemperature,
                  tooltip: 'Decrease desired temperature',
                  child: Icon(Icons.remove),
                  heroTag: "decrease temperature button",
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "${_desiredTemperature}°C",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                FloatingActionButton(
                  mini: true,
                  onPressed: _increaseDesiredTemperature,
                  tooltip: 'Increase desired temperature',
                  child: Icon(Icons.add),
                  heroTag: "increase temperature button",
                ),
              ]),
            ],
          )
        ),
      ),
      drawer: DrawerComponent(),
    );
  }
}

class TemperatureData {
  final String name;
  final String metric;
  final List<DataPoint> dataPoints;
  final int averageTemperature;

  TemperatureData(
      {required this.name,
      required this.metric,
      required this.dataPoints,
      required this.averageTemperature});

  factory TemperatureData.fromJson(Map<String, dynamic> json) {
    var dataPointsList = json['data_points'] as List;
    List<DataPoint> dataPoints =
        dataPointsList.map((i) => DataPoint.fromJson(i)).toList();
    var averageTemperature;
    var sum = 0.000;

    if (dataPoints.length < 3) {
      averageTemperature = null;
    } else {
      for (var i = 0; i < dataPoints.length; i++) {
        var currentValue = num.parse(dataPoints[i].value);
        sum = sum + currentValue;
      }
      var average = (sum / dataPoints.length);
      averageTemperature = average.toInt();
    }

    return TemperatureData(
      name: json['name'],
      metric: json['display_symbol'],
      dataPoints: dataPoints,
      averageTemperature: averageTemperature,
    );
  }
}

class DataPoint {
  final String value;
  final String timestamp;

  DataPoint({required this.value, required this.timestamp});

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(value: json['value'], timestamp: json['timestamp']);
  }
}
