import 'package:flutter/material.dart';
import 'package:mgcm_tools/screens/large/HomePageLarge.dart';
import 'package:mgcm_tools/screens/small/HomePageSmall.dart';

class HomePage extends StatefulWidget {
    HomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
        body:
        return LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
                return HomePageSmall(
                    title: widget.title,
                );
            } else {
                return HomePageLarge(
                    title: widget.title,
                );
            }
        });
    }
}
