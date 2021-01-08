import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mgcm_tools/db/CSVToModel.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/screens/DressesPage.dart';
import 'package:mgcm_tools/screens/HomePage.dart';
import 'package:mgcm_tools/screens/SettingsPage.dart';
import 'package:mgcm_tools/screens/SkillsPage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter();

  Hive.registerAdapter<DressSkill>(DressSkillAdapter());
  Hive.registerAdapter<Dress>(DressAdapter());
  Hive.registerAdapter<SkillTargetType>(SkillTargetTypeAdapter());
  Hive.registerAdapter<SkillEnhanceType>(SkillEnhanceTypeAdapter());
  Hive.registerAdapter<SkillEnhance>(SkillEnhanceAdapter());
  Hive.registerAdapter<Attribute>(AttributeAdapter());
  Hive.registerAdapter<Character>(CharacterAdapter());

  runApp(MagicamiTools());

  final dressBox = await Hive.openBox<Dress>('dresses');
  final skillsBox = await Hive.openBox<DressSkill>('skills');

  if (skillsBox.isEmpty || dressBox.isEmpty) {
    await CSVToModel.flutterLoadDefaultDB();
  }
}

class MagicamiTools extends StatelessWidget {
  final String title = "Magicami Tools";

  MagicamiTools();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Magicami Tools',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder>{
          '/': (context) => HomePage(title: 'Magicami Tools'),
          '/dresses': (context) => DressesPage(title: "Dresses"),
          '/skills': (context) => SkillsPage(title: "Skills"),
          '/settings': (context) => SettingsPage(
                title: "Settings",
              )
        });
  }
}
