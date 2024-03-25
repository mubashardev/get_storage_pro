library get_storage_pro;

export 'package:get_storage_pro/src/abstract_data_class.dart';
export 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage_pro/src/abstract_data_class.dart';
import 'package:get_storage/get_storage.dart';

/// A class providing utility methods for storing and retrieving objects using GetStorage.
class GetStoragePro {
  /// Retrieves an object of type [T] by its [id] from storage.
  ///
  /// Returns `null` if no object with the specified ID is found.
  static T? getById<T extends CommonDataClass<T>>(String id) {
    var key = "$T|$id";
    var savedMap = GetStorage().read<Map<String, dynamic>>(key) ?? {};
    try {
      var instance = CommonDataClass.createFromMap<T>(savedMap);
      return instance;
    } catch (e) {
      return null;
    }
  }

  /// Saves a list of objects of type [T] to storage.
  static void saveListToGetStorage<T extends CommonDataClass<T>>(
      List<CommonDataClass<T>> data) {
    for (var element in data) {
      var key = "$T|${element.id}";
      GetStorage().write(key, element.map);
    }
  }

  /// Saves a single object of type [T] to storage.
  static void addToGetStorage<T extends CommonDataClass<T>>(
      CommonDataClass<T> data) {
    var key = "$T|${data.id}";
    GetStorage().write(key, data.map);
  }

  /// Retrieves all saved objects of type [T] from storage.
  static List<T> getAllSaved<T extends CommonDataClass<T>>() {
    var requiredKeys = GetStorage()
        .getKeys<Iterable<String>>()
        .where((element) => element.startsWith("$T|"));
    var data = <T>[];
    for (var element in requiredKeys) {
      try {
        data.add(getById(element.split('|').last)!);
      } catch (_) {
        if (kDebugMode) {
          print(_);
        }
      }
    }
    return data;
  }
}
