import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  counterScreenState createState() => counterScreenState();
}

class counterScreenState extends State<CounterScreen> 
{
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async
  {
    var prefs = await SharedPreferences.getInstance();
    setState(()
    {
      counter = prefs.getInt('value') ?? 0;
    });
  }
  void _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('value', counter);
  }

  void _incrementCounter()
  {
    setState(() {
      counter++;
    });
    _saveCounter();
  }

  void _decrementCounter() {
    setState(() {
      counter--;
    });
    _saveCounter();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Persistent Counter App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter Value',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            Text(
              '$counter',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text('Increase'),
                ),
                SizedBox(width: 20),
                ElevatedButton(

                  onPressed: _decrementCounter,
                  child: Text('Decrease'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
