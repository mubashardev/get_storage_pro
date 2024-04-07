/// A base class for data model classes, must implement String [id], [fromMap] and [toMap] methods
///
/// ```dart
/// import 'package:get_storage_pro/src/common_data_class.dart';
///@get_storage_pro
/// class YourModel extends CommonDataClass<YourModel> {
///   final String id;
///   final String name;
///
///   YourModel({required this.id, required this.name});
///
///
///   factory YourModel.fromMap(Map<String, dynamic> map) {
///     return YourModel(
///       id: map['id'] as String,
///       name: map['name'] as String,
///     );
///   }
///
///   @override
///   Map<String, dynamic> toMap() {
///     return {'id': id, 'name': name};
///   }
/// }
/// ```
///
abstract class CommonDataClass<T extends CommonDataClass<T>> {
  /// The unique identifier for this data object. Must have String id attribute in your data class.
  String get id;

  /// A map representation of the data object.
  Map<String, dynamic> toMap();
}
