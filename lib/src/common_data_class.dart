/// A base class for data model classes, must implement String [id], [fromMap] and [toMap] methods
///
/// ```dart
/// import 'package:get_storage_pro/src/common_data_class.dart';
///
/// class YourModel extends CommonDataClass<YourModel> {
///   final String id;
///   final String name;
///
///   YourModel({required this.id, required this.name});
///
///   @override
///   YourModel fromMap(Map<String, dynamic> map) {
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

  /// Creates a new instance of the data object from a JSON map.
  T fromMap(Map<String, dynamic> map);

  /// A map of subclasses for each type of CommonDataClass.
  static final Map<String, CommonDataClass> _subclasses = {};

  /// Constructor for CommonDataClass.
  CommonDataClass() {
    _subclasses["$T"] = this;
  }

  /// Creates an instance of the data object from a map based on its type [T].
  static T? createFromMap<T extends CommonDataClass<T>>(
      Map<String, dynamic> map) {
    var type = _subclasses["$T"];
    if (type == null) {
      return null;
    } else {
      var obj = (type as T).fromMap(map);
      return obj;
    }
  }
}
