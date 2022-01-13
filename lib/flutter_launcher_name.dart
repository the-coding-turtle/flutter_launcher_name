library flutter_launcher_name;

import 'dart:io';

import 'package:flutter_launcher_name/android.dart' as android;
import 'package:flutter_launcher_name/constants.dart';
import 'package:flutter_launcher_name/ios.dart' as ios;
import 'package:yaml/yaml.dart';

Map<String, dynamic> loadConfigFile() {
  final File file = File('pubspec.yaml');
  final String yamlString = file.readAsStringSync();
  final Map yamlMap = loadYaml(yamlString);

  // yamlMap has the type YamlMap, which has several unwanted sideeffects
  final Map<String, dynamic> config = Map.from(yamlMap);

  return config;
}

void changeName(String newName) {
  try {
    print("Flutter Launcher name change to \"$newName\"");
    android.overwriteAndroidManifest(newName);
    ios.overwriteInfoPlist(newName);
    print(changeSuccessText);
  } catch (e) {
    print(changeFailText);
    print(e);
  }
}

exec(String? name) {
  print(startChangeHelpText);
  try {
    if (name == null) {
      final Map<String, dynamic> config = loadConfigFile();
      name = config["flutter_launcher_name"]?["name"];
      if (name == null) {
        name = config['name'];
      }
    }
  } catch (e) {
    print(changeFailText);
    print(e);
  }

  if (name != null) {
    changeName(name);
  }
}
