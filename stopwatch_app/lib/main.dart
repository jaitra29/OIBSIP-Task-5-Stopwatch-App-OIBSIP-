import 'package:flutter/material.dart';
import 'package:stopwatch_app/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Stopwatch App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StopwatchApp(),
    );
  }
}

