import 'package:uuid/uuid.dart';

String uniqueId() {
  var uuid = Uuid();
  return uuid.v1();
}
