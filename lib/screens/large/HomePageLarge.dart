import 'package:flutter/material.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/common/HomeCard.dart';
import 'package:mgcm_tools/widgets/common/WebAppBar.dart';

class HomePageLarge extends StatefulWidget {
  HomePageLarge({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageLargeState createState() => _HomePageLargeState();
}

class _HomePageLargeState extends State<HomePageLarge> {
  var _imagePaths = ["assets/home/dresses.png", "assets/home/skills.png"];
  var _titles = ["Dress Catalog", "Skills List"];
  var _descriptions = ["Look up dresses and their stats and skills", "Look up skills, enhance levels, power, and more"];
  var _navigateWidgets = [DressesRoute, SkillsRoute];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new AppDrawer(
          currentRoute: '/',
        ),
        appBar: WebAppBar('/'),
        body: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return new HomeCard(
                      _imagePaths[index], _titles[index], _descriptions[index], _navigateWidgets[index]);
                }),
          ),
        ));
  }
}
