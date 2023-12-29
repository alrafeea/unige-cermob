import 'dart:async';

import 'package:certifyapp/config/config.dart';
import 'package:certifyapp/core/viewModels/base_view_model.dart';
import 'package:certifyapp/pages/landing/landing_page.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/progress_indicator/app_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import 'arrow_back.dart';
import 'network_base_view.dart';

class AppScaffold extends StatefulWidget {
  final String appBarTitle;
  final Widget body;
  final bool isLoading;
  final bool isShowAppBar;
  final bool isShowArrowBack;
  final BaseViewModel baseViewModel;
  final Widget bottomSheet;
  final List<Widget> appBarActions;
 final  Color backgroundColor;
  final Function onTapArrowBack;

  AppScaffold(
      {@required this.body,
      this.appBarTitle = '',
      this.isLoading = false,
      this.isShowAppBar = false,
      this.baseViewModel,
      this.onTapArrowBack,
      this.isShowArrowBack = true,
      this.bottomSheet, this.backgroundColor, this.appBarActions});

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  StreamSubscription _intentDataStreamSubscription;
  TextEditingController urlController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String _platformVersion = 'Unknown';


  @override
  void initState() {

    // TODO: fix why is reopening the app even when he is in memory
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          if(value != null && value.isNotEmpty ) {
            print("app scaffold");
            handelUrl(value);

          }

        }, onError: (err) {
          print("getLinkStream error: $err");
        });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    // ReceiveSharingIntent.getInitialText().then((String value) {
    //   if(value != null && value.isNotEmpty )
    //     handelUrl(value);
    //
    // });
    super.initState();


  }

  handelUrl(String url){

    // showDialog(
    //     context: context,
    //     builder: (_) =>
    //     new AlertDialog(
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(10.0))
    //       ),
    //       content:Container(child: Text(url +  "AppScaffold"),),
    //     )
    // );
    NavigationUtils.appNavigator(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              LandingPage(url: url,preventListeningToSharing: true, ),
        )
      );
    });
    // AppDialogs.showAddNewsDialog(url: url, );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Utils.changeBottomBarSysStyle(context:context);
    AppGlobal.context = context;
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          backgroundColor:widget.backgroundColor??Color(0xFFF1F2F4) ,
          appBar: widget.isShowAppBar
              ? AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,

            textTheme: TextTheme(

              headline6: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            title: Text(widget.appBarTitle,style: Styles.titleTextStyle(fontSize:Sizes.TEXT_SIZE_20 ), ),

            leading: Builder(
              builder: (BuildContext context) {
                return  widget.isShowArrowBack? ArrowBack(onTap: widget.onTapArrowBack,):SizedBox();
              },
            ),
            centerTitle: true,
            actions:widget.appBarActions,

          )
              : null,
          body: widget.baseViewModel != null
              ? NetworkBaseView(
            baseViewModel: widget.baseViewModel,
            child: widget.body,
          )
              : Stack(
            children: <Widget>[
              widget.body,
              buildAppLoaderWidget(widget.isLoading),
            ],), bottomSheet: widget.bottomSheet,
        ),
      ),
    );
  }

  buildAppLoaderWidget(bool isLoading) {
    return isLoading ? AppLoaderWidget() : Container();
  }

  buildBodyWidget() {
    return Stack(children: <Widget>[widget.body, buildAppLoaderWidget(widget.isLoading)]);
  }
}


