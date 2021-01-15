import 'package:flutter/material.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget
{

  final String currentRoute;
  WebAppBar(this.currentRoute);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              InkWell(
                onTap: () {if(currentRoute != '/') Navigator.pushReplacementNamed(context, '/');},
              child: Text('MAGICAMI TOOLS',
              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white))),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {if(currentRoute != '/dresses') Navigator.pushReplacementNamed(context, '/dresses');},
                      child: Text(
                        'Dresses',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onTap: () {if(currentRoute != '/skills') Navigator.pushReplacementNamed(context, '/skills');},
                      child: Text(
                        'Skills',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(200.0);

}