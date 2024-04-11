import 'package:reflectable/reflectable.dart';

class GetStorageProReflector extends Reflectable {
  const GetStorageProReflector() : super(invokingCapability, typingCapability);
}

const gsp = GetStorageProReflector();
