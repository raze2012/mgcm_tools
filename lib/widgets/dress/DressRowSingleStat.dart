import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';

class DressRowSingleStat extends StatelessWidget {
  final Dress dress;
  final DressSort sortBy;
  String value;

  DressRowSingleStat(this.dress, this.sortBy) {
    final formatter = new NumberFormat("#,###");

    switch (sortBy) {
      case DressSort.HP:
        value = formatter.format(dress.hp80);
        break;
      case DressSort.ATK:
        value = formatter.format(dress.atk80);
        break;
      case DressSort.DEF:
        value = formatter.format(dress.def80);
        break;
      case DressSort.SPD:
        value = formatter.format(dress.spd80);
        break;
      case DressSort.FCS:
        value = formatter.format(dress.fcs);
        break;
      case DressSort.RES:
        value = formatter.format(dress.res);
        break;
      default:
        value = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.pushNamed(
              context,
              Uri(path: DressDetailsRoute, queryParameters: {'name': dress.name.replaceAll(' ', '_')}).toString(),
            );
          },
          child: Row(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: FadeInImage(
                  image: AssetImage("assets/dress/" + dress.id.toString() + ".png"),
                  placeholder: AssetImage("assets/dress/placeholder.png"),
                  width: 100,
                  height: 100,
                  fadeInDuration: Duration(milliseconds: 10),
                )),
            Expanded(
              child: Text(
                dress.name,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.all(10), child: Text(value, style: Theme.of(context).textTheme.headline5))),
          ])),
    );
  }
}
