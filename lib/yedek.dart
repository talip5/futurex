import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  Future<String> getTime() async{
    var url="http://worldclockapi.com/api/json/est/now";
    var response=await http.get(url);
    if(response.statusCode==200){
      var jsonObject=jsonDecode(response.body);
      return jsonObject['currentDataTime'];
    }
    else{
      return 'Error HTTP statuscode:${
          response.statusCode}';
    }
  }


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String date;
  Future<void> fetchTime() async{
    var temp=await widget.getTime();
    setState(() {
      date=temp;
    });
  }

  @override
  void initState(){
    fetchTime();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(date==null ? 'waiting' :date),
      ),
    );
  }
}
