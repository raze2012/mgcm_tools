import 'package:flutter/material.dart';
import 'package:mgcm_tools/model/Dress.dart';
import 'package:mgcm_tools/screens/common/DressDetailPage.dart';

class DressRow extends StatelessWidget {
  final Dress dress;

  DressRow(this.dress);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DressDetailPage(dressName: dress.name)),
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
              child: Image(
                image: AssetImage("assets/type/" + dress.type.toString().toLowerCase() + ".png"),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                    "assets/attribute/" +
                        dress.attribute.toString().toLowerCase().split('.').last.toLowerCase() +
                        ".png",
                    width: 50,
                    height: 50),
              ),
            )
          ])),
    );
  }
}
