abstract class CommonDataClass<T extends CommonDataClass<T>> {
  String get id;
  static Map<String, CommonDataClass> subclasses = {};
  Map<String, dynamic> get map;
  T fromJson(Map<String, dynamic> map);
  CommonDataClass() {
    subclasses["$T"] = this;
  }

  static T? createFromMap<T extends CommonDataClass<T>>(Map<String, dynamic> map) {
    var type = subclasses["$T"];
    if (type == null) {
      return null;
    } else {
      var obj = (type as T).fromJson(map);
      return obj;
    }
  }
}