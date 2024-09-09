import 'dart:convert';

import 'package:random_name_generator/random_name_generator.dart';
import 'dart:math';

List<Contact> contactListFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromMap(x)));

// show list contact to json
String contactListToJson({required List<Contact> data}) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Contact {
  final int? id;
  final String firstname;
  final String lastname;
  final int age;

  Contact({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.age,
  });

  Contact.init({
    this.id,
    this.firstname = '',
    this.lastname = '',
    this.age = 0,
  });

  // copyWith
  Contact copyWith({
    int? id,
    String? firstname,
    String? lastname,
    int? age,
  }) {
    return Contact(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      age: age ?? this.age,
    );
  }

  // Method to create a Contact instance from a map
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      age: map['age'],
    );
  }

  // Method to convert a Contact instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
    };
  }

// mock contact list 10 form lib random_name_generator
  List<Contact> mockContactList({required int count}) => List.generate(
        count,
        (index) => Contact(
          id: index,
          firstname: RandomNames(Zone.us).manName(),
          lastname: RandomNames(Zone.us).surname(),
          age: Random().nextInt(50),
        ),
      );
}
