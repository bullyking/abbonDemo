import 'dart:math';

import 'package:abbon_demo/core/models/contact/contact.dart';
import 'package:random_name_generator/random_name_generator.dart';

class PaginatedService {
  static final PaginatedService _instance = PaginatedService._internal();

  factory PaginatedService() {
    return _instance;
  }

  PaginatedService._internal();
  // fetching paginated data
  Future<List<Contact>?> fetchContacts({
    required int page,
    required int pageSize,
    List<Contact>? contactList,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final contacts = contactList ?? [];

    final start = (page - 1) * pageSize;
    final end = min(start + pageSize, 5);
    // final items = [];
    // items.addAll(contactList);
    // debugPrint(' items: ${items.length}');
    return contacts.sublist(start, end);
  }

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
