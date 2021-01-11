import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mgcm_tools/db/CSVValidator.dart';

void main() {
  test('validate skill table', () async {
    final file = new File('assets/skills.csv');

    var rawCSV = await file.readAsString();
    var csv = CsvToListConverter().convert(rawCSV);

    List<String> errorMessage = [];

    if (!CSVValidator.validateSkillHeaders(csv, errorMessage)) {
      errorMessage.clear();
      csv = CsvToListConverter(eol: "\n", shouldParseNumbers: true).convert(rawCSV);
    }

    var valid = CSVValidator.validateSkillTable(csv, errorMessage);
    if (errorMessage.isNotEmpty) print(errorMessage[0]);

    expect(valid, true, reason: errorMessage.isEmpty ? "Success!" : errorMessage[0]);
  });

  test('validate dress table', () async {
    final file = new File('assets/dresses.csv');

    var rawCSV = await file.readAsString();
    var csv = CsvToListConverter().convert(rawCSV);
    List<String> errorMessage = [];

    if (!CSVValidator.validateDressHeaders(csv, errorMessage)) {
      errorMessage.clear();
      csv = CsvToListConverter(eol: "\n", shouldParseNumbers: true).convert(rawCSV);
    }

    var valid = CSVValidator.validateDressTable(csv, errorMessage);
    if (errorMessage.isNotEmpty) print(errorMessage[0]);

    expect(valid, true, reason: errorMessage.isEmpty ? "Success!" : errorMessage[0]);
  });

  test('validate network skill table', () async {
    var response = await http.get(CSVValidator.skillURL);

    String rawCSV;

    if (response.statusCode == 200)
      rawCSV = response.body;
    else
      expect(false, true, reason: "failed network call. run test again");

    var csv = CsvToListConverter(eol: "\n", shouldParseNumbers: true).convert(rawCSV);

    List<String> errorMessage = [];
    var valid = CSVValidator.validateSkillTable(csv, errorMessage);
    if (errorMessage.isNotEmpty) print(errorMessage[0]);

    expect(valid, true, reason: errorMessage.isEmpty ? "Success!" : errorMessage[0]);
  });

  test('validate network dress table', () async {
    var response = await http.get(CSVValidator.dressURL);

    String rawCSV;

    if (response.statusCode == 200)
      rawCSV = response.body;
    else
      expect(false, true, reason: "failed network call. run test again");

    var csv = CsvToListConverter(eol: "\n").convert(rawCSV);

    List<String> errorMessage = [];
    var valid = CSVValidator.validateDressTable(csv, errorMessage);
    if (errorMessage.isNotEmpty) print(errorMessage[0]);

    expect(valid, true, reason: errorMessage.isEmpty ? "Success!" : errorMessage[0]);
  });
}
