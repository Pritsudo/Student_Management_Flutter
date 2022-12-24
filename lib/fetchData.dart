import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spring_flutter_practise/Student_Model.dart';
import 'package:spring_flutter_practise/UserDetails.dart';

class FetchData extends StatefulWidget {
  FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late List<Student> studentsList = [];

  Future<List<Student>> returnListOfStudents() async {
    var url = Uri.parse("http://10.0.2.2:8080/students/all");
    var responce = await http.get(url);
    final extractedData = json.decode(responce.body);
    List<Student> localVar = [];
    var l = extractedData.length;

    for (int i = 0; i < l; i++) {
      localVar.add(Student.fromMap(extractedData[i])
          // Student(
          //   address: extractedData[i]['address'],
          //   id: extractedData[i]['id'],
          //   name: extractedData[i]['name'])
          );
    }
    studentsList = localVar;
    return studentsList;
  }

  Future<void> deleteStudent(int id) async {
    var url = Uri.parse("http://10.0.2.2:8080/students/${id}");
    var responce = http.delete(url);
    responce.whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<Student>>(
            future: returnListOfStudents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Student> data = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.red,
                            elevation: 10,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Text('Id : ${data[index].id}',
                                      style: TextStyle(fontSize: 40.0)),
                                  title: Text('Name: ${data[index].name}',
                                      style: TextStyle(fontSize: 30.0)),
                                  subtitle: Text(
                                      'Address: ${data[index].address}',
                                      style: TextStyle(fontSize: 18.0)),
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    RaisedButton(
                                      child: const Text('Edit'),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserDetails(
                                                      isUpdate: true,
                                                      Id: data[index].id,
                                                    )));
                                      },
                                    ),
                                    RaisedButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          deleteStudent(data[index].id);
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return CircularProgressIndicator();
            }));
  }
}
