import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String _imagePath;
  final String _categoryName;
  final String _categoryDesc;
  final String _navigateTo;

  HomeCard(this._imagePath, this._categoryName, this._categoryDesc, this._navigateTo);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).pushNamed( _navigateTo);
          },
          child: Column(children: <Widget>[
            Center(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Image(image: AssetImage(_imagePath)),
            )),
            Center(
                child: Text(
              _categoryName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            )),
            const Divider(
              color: Colors.blueGrey,
              height: 10,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _categoryDesc,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            )),
          ])),
    );
  }
}
