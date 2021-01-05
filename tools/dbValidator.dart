import 'dart:io' show File;

import 'package:csv/csv.dart';
import 'package:mgcm_tools/db/CSVValidator.dart';

void main(List<String> args) async {
  if (args.length < 2) {
    print("syntax: dart dbValidator.dart [dressDB file] [skillDB file]");
    return;
  }

  var dressFile = await new File(args[0]).readAsString();
  var skillFile = await new File(args[1]).readAsString();

  var dressTable = CsvToListConverter().convert(dressFile);
  var skillTable = CsvToListConverter().convert(skillFile);

  List<String> errorMessage = [];

  if (!CSVValidator.validateDressHeaders(dressTable, errorMessage)) {
    errorMessage.clear();
    dressTable = CsvToListConverter().convert(dressFile, eol: "\n", shouldParseNumbers: true);
  }

  if (!CSVValidator.validateSkillHeaders(skillTable, errorMessage)) {
    errorMessage.clear();
    skillTable = CsvToListConverter().convert(skillFile, eol: "\n", shouldParseNumbers: true);
  }

  List<String> dressErrorMessage = [];
  List<String> skillErrorMessage = [];

  bool skillSuccess = CSVValidator.validateSkillTable(skillTable, dressErrorMessage);

  bool dressSuccess = CSVValidator.validateDressTable(dressTable, skillErrorMessage);

  if (dressSuccess)
    print("SUCCESS! Dress table is valid");
  else
    print("errors in dress table: " + dressErrorMessage.toString());

  if (skillSuccess)
    print("SUCCESS! Skill table is valid");
  else
    print("errors in skill table: " + skillErrorMessage.toString());
}
