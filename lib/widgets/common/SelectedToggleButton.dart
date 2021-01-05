import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedToggleButton extends StatefulWidget {
  _SelectedToggleButtonState createState() => _SelectedToggleButtonState();
}

class _SelectedToggleButtonState extends State<SelectedToggleButton> {
  List<String> _types;
  String type;

  @override
  Widget build(BuildContext context) {
    var ascending = true;
    return Opacity(
        opacity: ascending ? 1 : 0.2,
        child: IconButton(
          icon: Image(image: AssetImage("assets/type/" + type + ".png")),
          onPressed: () => setState(() {
            if (_types.contains(type))
              _types.remove(type);
            else
              _types.add(type);

            print(_types);
          }),
        ));
  }
}

