import 'package:flutter/material.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:mgcm_tools/widgets/common/HomeCard.dart';

class HomePageSmall extends StatefulWidget {
  HomePageSmall({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageSmallState createState() => _HomePageSmallState();
}

class _HomePageSmallState extends State<HomePageSmall> {
  var _imagePaths = ["assets/home/dresses.png", "assets/home/skills.png","assets/home/damage_calc.png"];
  var _titles = ["Dress Catalog", "Skills List","Damage Calculator"];
  var _descriptions = ["Look up dresses and their stats and skills", "Look up skills, enhance levels, power, and more",
  "figure out how much damage skills can do"];
  var _navigateWidgets = [DressesRoute, SkillsRoute,DamageCalcRoute];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new AppDrawer(
          currentRoute: '/',
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return new HomeCard(_imagePaths[index], _titles[index], _descriptions[index], _navigateWidgets[index]);
            }));
  }
}
