/// A base class for data model classes.
abstract class CommonDataClass<T extends CommonDataClass<T>> {
  /// The unique identifier for this data object.
  String get id;

  /// A map representation of the data object.
  Map<String, dynamic> get map;

  /// Creates a new instance of the data object from a JSON map.
  T fromJson(Map<String, dynamic> map);

  /// A map of subclasses for each type of CommonDataClass.
  static Map<String, CommonDataClass> subclasses = {};

  /// Constructor for CommonDataClass.
  CommonDataClass() {
    subclasses["$T"] = this;
  }

  /// Creates an instance of the data object from a map based on its type [T].
  static T? createFromMap<T extends CommonDataClass<T>>(
      Map<String, dynamic> map) {
    var type = subclasses["$T"];
    if (type == null) {
      return null;
    } else {
      var obj = (type as T).fromJson(map);
      return obj;
    }
  }
}
