import 'package:flutter/foundation.dart';
import 'package:reflectable/mirrors.dart';
import 'package:reflectable/reflectable.dart';
import '../get_storage_pro.dart';

/// A class providing utility methods for storing and retrieving objects using GetStorage.
class GetStoragePro {
  /// Retrieves an object of type [T] by its [id] from storage.
  ///
  /// Returns `null` if no object with the specified ID is found.
  static T? getObjectById<T extends CommonDataClass<T>>(String id) {
    var key = "$T\$$id";
    var savedMap = GetStorage("$T").read<Map<String, dynamic>>(key) ?? {};
    try {
      var classMirror = gsp.reflectType(T) as ClassMirror;
      var instance = classMirror.newInstance("fromMap", [savedMap]);
      return instance as T;
    } catch (e) {
      return null;
    }
  }

  /// Saves a list of objects of type [T] to storage.
  static void saveObjectsList<T extends CommonDataClass<T>>(
      List<CommonDataClass<T>> data) {
    _putAndInit("$T").then((value) {
      for (var element in data) {
        var key = "$T\$${element.id}";
        GetStorage("$T").write(key, element.toMap());
      }
    });
  }

  /// Saves a single object of type [T] to storage.
  static void saveObject<T extends CommonDataClass<T>>(
      CommonDataClass<T> data) {
    _putAndInit("$T").then((value) {
      var key = "$T\$${data.id}";
      GetStorage("$T").write(key, data.toMap());
    });
  }

  /// Retrieves all saved objects of type [T] from storage.
  static List<T> getAllObjects<T extends CommonDataClass<T>>() {
    var requiredKeys = GetStorage("$T").getKeys<Iterable<String>>();
    var data = <T>[];
    for (var element in requiredKeys) {
      try {
        data.add(getObjectById(element.split('\$').last)!);
      } catch (_) {
        debugPrint(_.toString());
      }
    }
    return data;
  }

  /// Removes the object with the specified [id] of type [T] from storage.
  static void deleteById<T extends CommonDataClass<T>>(String id) {
    var key = "$T\$$id";
    GetStorage("$T").remove(key);
  }

  /// Removes all objects of type [T] from storage.
  static void deleteAllObjects<T extends CommonDataClass<T>>() {
    var requiredKeys = GetStorage("$T").getKeys<Iterable<String>>();
    for (var element in requiredKeys) {
      deleteById<T>(element.split('\$').last);
    }
  }

  /// Erases all objects of all types from storage.
  static Future<void> eraseAll({bool eraseMainGetStorage = true}) async {
    List<String> allContainers = GetStorage().read("containers") ?? [];
    await Future.forEach(allContainers, (element) async {
      await GetStorage(element).erase();
    });
    if (eraseMainGetStorage) {
      await GetStorage().erase();
    }
  }

  /// Listens for changes to the object with the specified [id] of type [T].
  ///
  /// Calls [onData] with the updated object whenever changes occur.
  static void listenForObjectChanges<T extends CommonDataClass<T>>(
      {required String id, required Function(T?) onData}) {
    var key = "$T\$$id";
    // Initial Data
    onData(getObjectById(id));

    // Listen for changes
    GetStorage("$T").listenKey(key, (value) {
      onData(getObjectById(id));
    });
  }

  /// Listens for changes to all objects of type [T].
  ///
  /// Calls [onData] with the updated list of objects whenever changes occur.
  static void listenAllObjects<T extends CommonDataClass<T>>(
      {required Function(List<T>) onData}) {
    // Initial Data
    onData(getAllObjects());

    // Listen for changes
    GetStorage("$T").listen(() {
      onData(getAllObjects());
    });
  }

  /// Start the storage drive. It's important to use await before calling this API, or side effects will occur.
  ///
  /// [GetStoragePro] will only work if you call `GetStoragePro.init()` first.
  ///
  /// No need to call `GetStorage.init()`
  static Future<void> init() async {
    await GetStorage.init();
    List<String> allContainers =
        (GetStorage().read("containers") as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList();
    await Future.forEach(allContainers, (element) async {
      await GetStorage.init(element);
    });
  }

  static Future<void> _putAndInit(String container) async {
    List<String> allContainers =
        (GetStorage().read("containers") as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList();
    if (!allContainers.contains(container)) {
      allContainers.add(container);
      await GetStorage().write("containers", allContainers);
      await GetStorage.init(container);
    }
  }
}
