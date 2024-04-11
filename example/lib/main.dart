import 'package:flutter/material.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:reflectable/reflectable.dart';

import 'main.reflectable.dart';

void main() async {
  initializeReflectable();
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize GetStoragePro (call this before using any GetStoragePro functionality)
  await GetStoragePro.init();

  // Your code here...
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'CommonDataClass Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommonDataClass Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Example usage of CommonDataClass and its subclasses
            User user = User(id: '1', name: 'John');
            debugPrint(user.toMap().toString()); // Output: {id: 1, name: John}

            GetStoragePro.saveObject(user);
          },
          child: const Text('Run Example'),
        ),
      ),
    );
  }
}

// Example subclass of CommonDataClass
@gsp
class User extends CommonDataClass<User> {
  @override
  final String id;
  final String name;

  User({required this.id, required this.name});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
