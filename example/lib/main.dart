import 'package:flutter/material.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

void main() async {
  await GetStorage.init();
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
            debugPrint(user.map.toString()); // Output: {id: 1, name: John}

            GetStoragePro.addToGetStorage<User>(user);
          },
          child: const Text('Run Example'),
        ),
      ),
    );
  }
}

// Example subclass of CommonDataClass
class User extends CommonDataClass<User> {
  final String id;
  final String name;

  User({required this.id, required this.name});

  @override
  User fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  Map<String, dynamic> get map => {'id': id, 'name': name};
}
