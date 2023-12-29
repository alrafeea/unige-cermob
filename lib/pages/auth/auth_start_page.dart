import 'package:certifyapp/pages/auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forget_password.dart';
import 'login.dart';

// ignore: must_be_immutable
class AuthStartPage extends StatefulWidget {
 final Function onSuccess;
  const AuthStartPage({Key key, this.onSuccess}) : super(key: key);

  @override
  _AuthStartPageState createState() => _AuthStartPageState();
}

class _AuthStartPageState extends State<AuthStartPage>
    with TickerProviderStateMixin {
  PageController _controller;
  int _currentIndex = 0;

  changePageViewIndex(pageIndex) {
    _currentIndex = pageIndex;
    _controller.jumpToPage(pageIndex);
  }

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _controller = new PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 1,

        // height: MediaQuery
        //     .of(context)
        //     .size
        //     .height * 0.7,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          // scrollDirection: Axis.vertical,\
          // physics: BouncingScrollPhysics(),
          controller: _controller,

          // scrollDirection: Axis.horizontal,
          children: <Widget>[
            Login(
              changePageViewIndex: changePageViewIndex,
              onSuccess: widget.onSuccess,
              currentIndex: _currentIndex,
            ),
            ForgetPassword(changePageViewIndex: changePageViewIndex),
            SignUp(
              changePageViewIndex: changePageViewIndex,
              onSuccess: widget.onSuccess,
              currentIndex: _currentIndex,
            ),
          ],
        ),
      ),
    );
  }
}



