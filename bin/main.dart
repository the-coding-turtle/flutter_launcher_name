import 'package:flutter_launcher_name/flutter_launcher_name.dart'
    as FlutterName;

main(List<String> arguments) {
  var name;
  if (arguments.length >= 1) {
    name = arguments[0];
  }
  FlutterName.exec(name);
}
