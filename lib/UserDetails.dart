import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spring_flutter_practise/Student_Model.dart';
import 'package:spring_flutter_practise/fetchData.dart';

class UserDetails extends StatefulWidget {
  bool isUpdate;
  int Id;
  UserDetails({required this.isUpdate, required this.Id});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      fetchUser(Id: widget.Id);
    }
    super.initState();
  }

  Future<void> submitStudent() async {
    var url = Uri.parse("http://10.0.2.2:8080/students");
    //Student student = Student(address: address, id: 2, name: name);
    var body = json.encode({
      "address": _addressController.text,
      "name": _nameController.text,
    });
    var status = await http
        .post(url, body: body, headers: {"content-type": "application/json"});
    var code = status.statusCode;
    print("Status is : $code");
     Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FetchData()));
  }

  void fetchUser({required int Id}) async {
    if (widget.isUpdate) {
      var url = Uri.parse("http://10.0.2.2:8080/students/$Id");
      final responce = await http.get(url);
      final extractData = json.decode(responce.body);
      _addressController.text = extractData['address'];
      _nameController.text = extractData['name'];
    }
  }

  void updateUser({required int Id}) async {
    if (widget.isUpdate) {
      var url = Uri.parse("http://10.0.2.2:8080/students/$Id");
      final body = json.encode(
          {'address': _addressController.text, 'name': _nameController.text});
      final responce = await http.patch(url,
          body: body, headers: {"content-type": "application/json"});
      print('Responce : ${responce.statusCode}');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FetchData()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter name',
                  labelText: 'Name',
                ),
                controller: _nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.add_comment),
                  hintText: 'address',
                  labelText: 'address',
                ),
                controller: _addressController,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: RaisedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (widget.isUpdate)
                        updateUser(Id: widget.Id);
                      else
                        submitStudent();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
