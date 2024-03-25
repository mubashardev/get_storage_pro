# get_storage_pro

A Flutter package dependent on [`get_storage`](https://pub.dev/packages/get_storage) for extending functionalities of [`get_storage`](https://pub.dev/packages/get_storage).

## Overview

`get_storage_pro` simplifies the process of storing and retrieving objects directly to/from storage, eliminating the need to manually convert objects to maps and vice versa. It provides functionalities to store objects, lists of objects, and fetch single or multiple objects from storage.

## Usage

1. Define your model classes by extending `CommonDataClass` and implementing required functions. Ensure your model class includes an `id` attribute of type `String`.

```dart
import 'package:get_storage_pro/src/abstract_data_class.dart';

class YourModel extends CommonDataClass<YourModel> {
  final String id;
  final String name;

  YourModel({required this.id, required this.name});

  @override
  YourModel fromMap(Map<String, dynamic> map) {
    return YourModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  Map<String, dynamic> get map => {'id': id, 'name': name};
}
```
## Use `GetStoragePro` to store and fetch data:

```dart
import 'package:get_storage_pro/get_storage_pro.dart';

void main() {
  // Save a single object
  YourModel model = YourModel(id: '1', name: 'John');
  GetStoragePro.addToGetStorage(model);

  // Save a list of objects
  List<YourModel> models = [
    YourModel(id: '2', name: 'Alice'),
    YourModel(id: '3', name: 'Bob'),
  ];
  GetStoragePro.saveListToGetStorage(models);

  // Get a single object by ID
  YourModel? retrievedModel = GetStoragePro.getById<YourModel>('1');
  print(retrievedModel?.name); // Output: John

  // Get all saved objects
  List<YourModel> allModels = GetStoragePro.getAllSaved<YourModel>();
  print(allModels.length); // Output: 3 (including the previously saved objects)
}
```

# API
## `GetStoragePro`

`static T? getById<T extends CommonDataClass<T>>(String id)`
* Retrieves an object of type `T` by its ID from storage.
* Returns `null` if no object with the specified ID is found.
  `static void saveListToGetStorage<T extends CommonDataClass<T>>(List<CommonDataClass<T>> data)`
* Saves a list of objects of type `T` to storage.
  `static void addToGetStorage<T extends CommonDataClass<T>>(CommonDataClass<T> data)`
* Saves a single object of type `T` to storage.
  `static List<T> getAllSaved<T extends CommonDataClass<T>>()`
* Retrieves all saved objects of type T from storage.
## `CommonDataClass`
* A base class for model classes.
* Provides functions `fromMap` and `map` which need to be implemented by subclassing model classes.

```dart
abstract class CommonDataClass<T extends CommonDataClass<T>> {
String get id;
Map<String, dynamic> get map;

T fromMap(Map<String, dynamic> map);

// Other abstract methods and properties...
}
```

## Note
Ensure your model classes must extend `CommonDataClass` and implement the required functions.
This package relies on the [`get_storage`](https://pub.dev/packages/get_storage) package for storage functionality.

#
## Additional Notes

- This is a basic implementation. In the future, more features will be added and existing ones will be improved.
- Contributions are welcome! This package is open-source, and anyone can fork and contribute to it to make it more powerful and easy to use.
- Pull requests will be actively reviewed and accepted after verification.
