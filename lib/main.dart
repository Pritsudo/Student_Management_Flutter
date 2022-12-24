import 'package:flutter/material.dart';
import 'package:spring_flutter_practise/fetchData.dart';
import 'package:spring_flutter_practise/UserDetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      //  UserDetails(isUpdate: false, Id: 1)
      FetchData(),
    );
  }
}
