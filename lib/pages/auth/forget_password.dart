import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatefulWidget {
  final int currentIndex;
  final Function changePageViewIndex;


  ForgetPassword({Key key, this.currentIndex, this.changePageViewIndex}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String _email;

  bool _isLoading = false;

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.10),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Forgot password",
                      style: Styles.titleTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.TEXT_SIZE_22),
                    ),
                  ],
                ),
                SizedBox(height: 18.0),
                Container(
                  height: 33,
                  child: TextFields(
                    readOnly: _isLoading,
                    initialValue: _email,
                    hintText: "Email Address",
                    type: "email",
                    prefixIcon: CertifyIcon.email_signin,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Please enter your Email";
                      else if (!value.contains("@") ||
                          error == "ERROR_INVALID_EMAIL")
                        return "Please enter a valid Email.";
                      else if (error == "ERROR_USER_NOT_FOUND")
                        return "User doesn't exist. Try again.";
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    onChanged: (value){
                      setState(() {
                        _email = value;
                      });
                    },
                    onSaved: (value) => _email = value,
                  ),
                ),
                SizedBox(height: 12.0),
                if(error.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: 7,),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Texts(error.toString(), color: Color.fromRGBO(235, 80, 60, 1.0), variant: "caption2"),
                          ),
                        ],
                      ),
                      SizedBox(height: 7,),
                    ],
                  ),

                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SecondaryButton(
                            label: "Reset password",
                            disabled: _email == null,
                            onTap: () {
                              _resetPassword();
                            },
                            loading: _isLoading),
                      ),
                    ],
                  ),
                ),
                SpaceH36(),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          child: Text(
                            "Log In",
                            style: Styles.ratingTextStyle(
                                fontSize: 12, color: AppColors.grey),
                          ),
                          onTap: () {
                            widget.changePageViewIndex(0);
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        child: Row(
                          children: [
                            Text(
                              "Create Your Account ",
                              style: Styles.ratingTextStyle(
                                  fontSize: 12, color: AppColors.grey),
                            ),
                            Icon(
                              FontAwesomeIcons.arrowRight,
                              color: Colors.grey,
                              size: 15,
                            )
                          ],
                        ),
                        onTap: () {
                          widget.changePageViewIndex(2);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _resetPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthViewModel>(context, listen: false).sendPasswordResetEmail(_email.trim());
      Utils.showSuccessCustomAppToast(msg:"Reset Password Link Sent to Your Email ");

      widget.changePageViewIndex(0);


    } catch (e) {
      try {
        setState(() {
          _isLoading = false;
          error = e["code"];
        });
      } catch (_) {
        setState(() {
          _isLoading = false;
          error = e.code;
        });
      }
    }
  }
}
