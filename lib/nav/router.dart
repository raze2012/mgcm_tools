import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';
import 'package:mgcm_tools/nav/routingData.dart';
import 'package:mgcm_tools/screens/SettingsPage.dart';
import 'package:mgcm_tools/screens/common/DressDetailPage.dart';
import 'package:mgcm_tools/screens/common/DressesPage.dart';
import 'package:mgcm_tools/screens/common/HomePage.dart';
import 'package:mgcm_tools/screens/common/SkillsPage.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var url = RoutingData.getRoutingData(settings.name);

  switch (url.route) {
    case HomeRoute:
      return MaterialPageRoute(settings: settings,builder: (context) => HomePage(title: 'Magicami Tools'));
    case DressesRoute:
      return MaterialPageRoute(settings: settings,builder: (context) => DressesPage(title: 'Dresses'));
    case DressDetailsRoute:
      String name = url['name'];
      int id = url['id'];
      if(name != null)
        name = name.replaceAll('_', ' ');
      return MaterialPageRoute(settings: settings,builder: (context) => DressDetailPage(id,name));
    case SkillsRoute:
      return MaterialPageRoute(settings: settings,builder: (context) => SkillsPage(title: 'Skills'));
    case SettingsRoute:
      if(kIsWeb)
        return MaterialPageRoute(settings: settings,builder: (context) => HomePage(title: 'Magicami Tools'));
      else
        return MaterialPageRoute(settings: settings,builder: (context) => SettingsPage(title: 'Settings'));
      break;
    default:
      return MaterialPageRoute(settings: settings,builder: (context) => HomePage(title: 'Magicami Tools'));
  }
}