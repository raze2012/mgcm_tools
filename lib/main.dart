import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mgcm_tools/db/CSVToModel.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSkill.dart';
import 'package:mgcm_tools/model/ModelEnums.dart';
import 'package:mgcm_tools/nav/router.dart' as router;

import 'nav/routeConsts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter<DressSkill>(DressSkillAdapter());
  Hive.registerAdapter<Dress>(DressAdapter());
  Hive.registerAdapter<SkillTargetType>(SkillTargetTypeAdapter());
  Hive.registerAdapter<SkillEnhanceType>(SkillEnhanceTypeAdapter());
  Hive.registerAdapter<SkillEnhance>(SkillEnhanceAdapter());
  Hive.registerAdapter<Attribute>(AttributeAdapter());
  Hive.registerAdapter<Character>(CharacterAdapter());

  final dressBox = await Hive.openBox<Dress>('dresses');
  final skillsBox = await Hive.openBox<DressSkill>('skills');

  if (skillsBox.isEmpty || dressBox.isEmpty) {
    await CSVToModel.flutterLoadDefaultDB();
  }

  runApp(MagicamiTools());
}

class MagicamiTools extends StatelessWidget {
  final String title = "Magicami Tools";
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MagicamiTools();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Magicami Tools',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        onGenerateRoute: router.generateRoute,
        initialRoute: HomeRoute,
        );
  }

}
