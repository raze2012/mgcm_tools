import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppDrawer extends Drawer {
  final String currentRoute;

  AppDrawer({this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Magicami Tools',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: Image(image: AssetImage('assets/home/home.png')),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                if (currentRoute != '/') {
                  Navigator.pushReplacementNamed(context, '/');
                }
              }),
          ListTile(
              leading: Image(image: AssetImage('assets/home/dresses.png')),
              title: Text('Dresses'),
              onTap: () {
                Navigator.pop(context);
                if (currentRoute != '/dresses') {
                  Navigator.pushNamedAndRemoveUntil(context, '/dresses', ModalRoute.withName('/'));
                }
              }),
          ListTile(
              leading: Image(image: AssetImage('assets/home/skills.png')),
              title: Text('Skills'),
              onTap: () {
                Navigator.pop(context);
                if (currentRoute != '/skills') {
                  Navigator.pushNamedAndRemoveUntil(context, '/skills', ModalRoute.withName('/'));
                }
              }),
          const Divider(
            color: Colors.blueGrey,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Visibility(
              visible: !kIsWeb,
            child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  if (currentRoute != '/settings') {
                    Navigator.pushNamed(context, '/settings');
                  }
                }),
          ),
          // ListTile
          // (
          //     leading: Icon(Icons.info_outline),
          //     title: Text('About'),
          // ),
        ],
      ),
    );
  }
}
