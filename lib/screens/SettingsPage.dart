import 'package:flutter/material.dart';
import 'package:mgcm_tools/db/CSVToModel.dart';
import 'package:mgcm_tools/widgets/common/AppDrawer.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  showAlertDialog(BuildContext context, void Function() action) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        action();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure? Action cannot be undone"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void loadDBFromNetwork() async {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text("Loading default sheets..."),
          )
        ],
      ),
    ));

    bool result = await CSVToModel.networkLoadDB().timeout(
      Duration(seconds: 10),
      onTimeout: () => false,
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[new Text(result ? "Load successful." : "load failed. please try again")],
      ),
    ));
  }

  void loadDefaults() async {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text("Loading default sheets..."),
          )
        ],
      ),
    ));

    await CSVToModel.flutterLoadDefaultDB();

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      duration: new Duration(seconds: 4),
      content: new Row(
        children: <Widget>[new Text("Load successful.")],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new AppDrawer(
          currentRoute: '/settings',
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: 'Update DB',
              titlePadding: EdgeInsets.all(15),
              tiles: [
                SettingsTile(
                  title: 'Update from Internet',
                  subtitle: 'uses google sheet to update, if anyone is maintaining it',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) async {
                    showAlertDialog(context, loadDBFromNetwork);
                  },
                ),
                SettingsTile(
                  title: 'Load Custom Dress Sheet',
                  leading: Icon(Icons.file_upload),
                  onPressed: (BuildContext context) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(duration: Duration(seconds: 4), content: Text("Coming soon")));
                  },
                ),
                SettingsTile(
                  title: 'Load Custom Skill Sheet',
                  leading: Icon(Icons.file_upload),
                  onPressed: (BuildContext context) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(duration: Duration(seconds: 4), content: Text("Coming soon")));
                  },
                ),
                SettingsTile(
                  title: 'Reset to default',
                  subtitle: 'in case all goes wrong, use built in base sheet',
                  leading: Icon(Icons.reset_tv),
                  onPressed: (BuildContext context) async {
                    showAlertDialog(context, loadDefaults);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
