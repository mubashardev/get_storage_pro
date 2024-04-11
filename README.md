# 💾 Get Storage Pro 💾

[![Pub](https://img.shields.io/pub/v/get_storage_pro)](https://pub.dartlang.org/packages/get_storage_pro)
[![Pub](https://img.shields.io/github/stars/MicroProgramer/get_storage_pro)](https://github.com/MicroProgramer/get_storage_pro)
[![Pub](https://img.shields.io/github/last-commit/MicroProgramer/get_storage_pro)](https://github.com/MicroProgramer/get_storage_pro)



A Flutter package dependent on [`get_storage`](https://pub.dev/packages/get_storage) for extending functionalities of [`get_storage`](https://pub.dev/packages/get_storage).

## Overview

`get_storage_pro` simplifies the process of storing and retrieving objects directly to/from storage, eliminating the need to manually convert objects to maps and vice versa. It provides functionalities to store objects, lists of objects, and fetch single or multiple objects from storage.

**Important**: Before using `GetStoragePro`, ensure you call `GetStoragePro.init()` to initialize the package. Unlike `get_storage`, there's no need to call `GetStorage.init()` separately.


### Example:

```dart
import 'package:get_storage_pro/get_storage_pro.dart';
import 'main.reflectable.dart';

void main() async {
  initializeReflectable();
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStoragePro (call this before using any GetStoragePro functionality)
  await GetStoragePro.init();

  // Your code here...
  runApp(const MyApp());
}
```

---

# 🔨 Usage

1. Define your model classes annotating with `@gsp` and extending `CommonDataClass` and implementing required functions. Ensure your model class includes an `id` attribute of type `String`. And implement `fromMap` and `toMap` methods.

```dart
import 'package:get_storage_pro/src/common_data_class.dart';

@gsp
class YourModel extends CommonDataClass<YourModel> {
  final String id;
  final String name;

  YourModel({required this.id, required this.name});

  //Must have a factory named constructor fromMap
  factory YourModel.fromMap(Map<String, dynamic> map) {
    return YourModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
```

2. Now run the command in your terminal of project root: `dart pub run build_runner build`

This will create a new file `main.reflectable.dart` in root folder of your project, don't change anything in that file.

3. Now just call `initializeReflectable();` in `main.dart` main function.


## Use `GetStoragePro` to store and fetch data:

```dart
import 'package:get_storage_pro/get_storage_pro.dart';
import 'main.reflectable.dart';

void main() {
  initializeReflectable();

  // Save a single object
  YourModel model = YourModel(id: '1', name: 'John');
  GetStoragePro.saveObject(model);

  // Save a list of objects
  List<YourModel> models = [
    YourModel(id: '2', name: 'Alice'),
    YourModel(id: '3', name: 'Bob'),
  ];
  GetStoragePro.saveObjectsList(models);

  // Get a single object by ID
  YourModel? retrievedModel = GetStoragePro.getObjectById<YourModel>('1');
  print(retrievedModel?.name); // Output: John

  // Get all saved objects
  List<YourModel> allModels = GetStoragePro.getAllObjects<YourModel>();
  print(allModels.length); // Output: 3 (including the previously saved objects)

  // Remove an object by ID
  GetStoragePro.deleteById<YourModel>('1');

  // Remove all objects of type YourModel
  GetStoragePro.deleteAllObjects<YourModel>();

  // Listen for changes to a specific object by ID
  GetStoragePro.listenForObjectChanges<YourModel>(id: '1', onData: (model) {
    print('Updated model: ${model?.name}');
  });

  // Listen for changes to all objects of type YourModel
  GetStoragePro.listenAllObjects<YourModel>(onData: (models) {
    print('All models: $models');
  });
}
```

# 📢 Functionality
## `GetStoragePro`

* `T? getObjectById<T extends CommonDataClass<T>>(String id)`: Retrieves an object of type T by its ID from storage. Returns null if no object with the specified ID is found.
* `void saveObjectsList<T extends CommonDataClass<T>>(List<CommonDataClass<T>> data)`: Saves a list of objects of type T to storage.
* `void saveObject<T extends CommonDataClass<T>>(CommonDataClass<T> data)`: Saves a single object of type T to storage.
* `List<T> getAllObjects<T extends CommonDataClass<T>>()`: Retrieves all saved objects of type T from storage.
* `void deleteById<T extends CommonDataClass<T>>(String id)`: Removes the object with the specified ID of type T from storage.
* `void deleteAllObjects<T extends CommonDataClass<T>>()`: Removes all objects of type T from storage.
* `void listenForObjectChanges<T extends CommonDataClass<T>>({required String id, required Function(T?) onData})`: Listens for changes to a specific object of type T by its ID. Calls onData with the updated object whenever changes occur.
* `void listenAllObjects<T extends CommonDataClass<T>>({required Function(List<T>) onData})`: Listens for changes to all objects of type T. Calls onData with the updated list of objects whenever changes occur.


## 📓 Note
Ensure your model classes must extend `CommonDataClass` and implement the required functions.
This package relies on the [`get_storage`](https://pub.dev/packages/get_storage) package for storage functionality.

- This is a basic implementation. In the future, more features will be added and existing ones will be improved.

# 👋 Get Involved

If this package is useful to you please 👍 on [pub.dev](https://pub.dev/packages/get_storage_pro) and ⭐ on [GitHub](https://github.com/MicroProgramer/get_storage_pro). If you have any Issues, recommendations or pull requests I'd love to see them!