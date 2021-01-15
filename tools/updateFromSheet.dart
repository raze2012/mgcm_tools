import 'dart:io' show File, Platform, Directory;

import 'package:http/http.dart' as http;
import 'package:mgcm_tools/db/CSVValidator.dart';
import "package:path/path.dart" show dirname, join;

/*
    convience tool for development. uses provided google sheet URL and saves the csv used for app. execute in project directory
 */
void main() async {
  writeToCSV(CSVValidator.dressURL, "assets/dresses.csv");
  writeToCSV(CSVValidator.skillURL, "assets/skills.csv");
}

void writeToCSV(String url, String relativePath) async {
  var response = await http.get(url);

  var csv;

  if (response.statusCode == 200)
    csv = response.body;
  else {
    print("response code " + response.statusCode.toString());
    return;
  }
  var baseDir = Directory(dirname(Platform.script.toFilePath())).parent.path;
  var dir = join(baseDir, relativePath);
  File(dir).createSync();

  File file = File(dir);

  file.writeAsString(csv);
}
