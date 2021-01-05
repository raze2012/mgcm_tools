import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/model/DressSort.dart';
import 'package:mgcm_tools/screens/DressDetailPage.dart';
import 'package:mgcm_tools/widgets/common/SilverGridDelegateCustomHeight.dart';

class DressRowStats extends StatelessWidget {
  final Dress dress;
  final formatter = new NumberFormat("#,###");
  String value;
  DressSort sortby;

  DressRowStats(this.dress, this.sortby);

  @override
  Widget build(BuildContext context) {
    List<String> mainInfo = [
      "HP",
      "ATK",
      "DEF",
      "SPD",
      formatter.format(dress.hp80),
      formatter.format(dress.atk80),
      formatter.format(dress.def80),
      formatter.format(dress.spd80)
    ];

    List<String> subInfo = ["FCS", "RES", formatter.format(dress.fcs), formatter.format(dress.res)];

    bool isMain = !(sortby == DressSort.FCS || sortby == DressSort.RES);

    List<String> info = isMain ? mainInfo : subInfo;

    var columnCount = isMain ? 4 : 2;
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DressDetailPage(title: dress.name)),
            );
          },
          child: Row(children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: FadeInImage(
                  image: AssetImage("assets/dress/" + dress.id.toString() + ".png"),
                  placeholder: AssetImage("assets/dress/placeholder.png"),
                  width: 100,
                  height: 100,
                  fadeInDuration: Duration(milliseconds: 10),
                )),
            Flexible(
                flex: 1,
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  itemCount: info.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    height: 50,
                    crossAxisCount: columnCount,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: index < columnCount ? Colors.blue : Colors.white,
                        border: Border.all(
                          color: Colors.black54,
                          width: 0.3,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        info[index],
                        style: TextStyle(color: index < columnCount ? Colors.white : Colors.black),
                      )),
                    );
                  },
                ))
          ])),
    );
  }
}
