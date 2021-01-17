import 'package:flutter/material.dart';
import 'package:mgcm_tools/nav/routeConsts.dart';

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
                onTap: () {if(currentRoute != HomeRoute) Navigator.pushNamed(context, HomeRoute);},
              child: Text('MAGICAMI TOOLS',
              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white))),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {if(currentRoute != DressesRoute) Navigator.pushNamed(context, DressesRoute);},
                      child: Text(
                        'Dresses',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onTap: () {if(currentRoute != SkillsRoute) Navigator.pushNamed(context, SkillsRoute);},
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