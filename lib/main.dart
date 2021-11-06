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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<String> getTime() async{
    print('tamam');
    var url="http://worldclockapi.com/api/json/est/now";
    print('http');
    var response=await http.get(url);
    print('await');
    if(response.statusCode==200){
      print('response');
      var jsonObject=jsonDecode(response.body);
      return jsonObject['currentFileTime'];
    }
    else{
      return 'Error HTTP statuscode:${
          response.statusCode}';
    }
  }

  int _counter = 0;
  String date;
  Future timeFuture;

  Future<void> fetchTime() async{
    var temp=await getTime();
    setState(() {
      date=temp;
    });
  }

 /* @override
  void initState(){
    fetchTime();
    super.initState();
  }*/

  void _incrementCounter() {
    setState(() {
        _counter++;
    });
  }

  @override
  void initState(){
    print('initstate');
    timeFuture=getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
             title: Text(widget.title),
      ),
      body:FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Center(
              child: Text(snapshot.data,
              ),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: timeFuture,
      ),
      );
  }
}
