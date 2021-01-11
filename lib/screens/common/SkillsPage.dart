import 'package:flutter/material.dart';
import 'package:mgcm_tools/screens/large/SkillsPageLarge.dart';
import 'package:mgcm_tools/screens/small/SkillsPageSmall.dart';

class SkillsPage extends StatefulWidget {
  SkillsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  @override
  Widget build(BuildContext context) {
    body:
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return SkillsPageSmall(
          title: widget.title,
        );
      } else {
        return SkillsPageLarge(
          title: widget.title,
        );
      }
    });
  }
}
