import 'package:flutter/material.dart';

class SkillPopup extends StatelessWidget {
  final String imgDir;
  final String name;
  final String desc;

  const SkillPopup({Key key, this.imgDir, this.name, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Image.asset(imgDir),
        ),
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5.copyWith(decoration: TextDecoration.underline),
              ),
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ))
      ],
    );
  }
}
