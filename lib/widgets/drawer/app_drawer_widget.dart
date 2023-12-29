import 'package:certifyapp/uitl/translations_delegate_base.dart';
import 'package:certifyapp/widgets/data_display/list/flexible_container.dart';
import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import 'drawer_item_widget.dart';



class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return FlexibleContainer(
      child: Container(
        color: Colors.white,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: SizeConfig.heightMultiplier * 50,
                      child: InkWell(
                        child: DrawerHeader(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Image.asset('assets/images/logo.png'),
                                margin: EdgeInsets.only(top: 10, bottom: 15),
                              ),
                              SizedBox(
                                height: 1,
                                child: Container(
                                  color: Colors.black26,
                                ),
                              ),
                              SizedBox(height: 15),
                              CircleAvatar(
                                radius: SizeConfig.imageSizeMultiplier * 12,
                                backgroundColor: Colors.white,
                                //TODO add backgroundImage: NetworkImage(''),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Texts(
                                    'Patient',
                                    color: Colors.black,
                                    fontSize: SizeConfig.textMultiplier * 2,
                                  )),
                              Texts("Director of medical records",
                                  //TODO: Make The Dr Title Dynamic and check overflow issue.

                                  color: Colors.black87),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                                child: Texts(
                                  TranslationBase.of(context).logout,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  //TODO add await helpers.logout();
                                },
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          //TODO add fun
                        },
                      ),
                    ),
                    InkWell(
                      child: DrawerItem(
                          TranslationBase.of(context).settings, Icons.settings),
                      onTap: () {
                        Navigator.pop(context);
                        //TODO add fun
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Container(
                      // This align moves the children to the bottom
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text("Powered by"),
                              Image.asset(
                                'assets/images/cs_logo_container.png',
                                width: SizeConfig.imageSizeMultiplier * 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  drawerNavigator(context, routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
