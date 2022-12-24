import 'dart:convert';

class Student {
  final String address;
  final int id;
  final String name;

  Student({
    required this.address,
    required this.id,
    required this.name,
  }
  );

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id':id,
  //     'address':address,
  //     'name':name,
  //   };
  // }

 


  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      address: map['address'],
      id: map['id'],
      name: map['name'],
    );
  }

  
}
