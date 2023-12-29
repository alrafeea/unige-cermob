import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/pages/auth/validationError.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final int currentIndex;
  final Function changePageViewIndex;
  final Function  onSuccess;

  Login({Key key, this.currentIndex, this.changePageViewIndex, this.onSuccess})
      : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  bool _isLoading = false;
  String error = "";
  String userErrorMsg = "";

  void _validateAndSubmit(String type) {
    setState(() {
      error = "";
      userErrorMsg ="";
    });
    final form = formKey.currentState;
    if (type == "email") {
      form.save();


      if (!_email.contains("@") ||
          error  == "ERROR_INVALID_EMAIL")
        userErrorMsg ="Please enter a valid Email.";



      if (_password.isEmpty)
        userErrorMsg= 'Please enter your Password.';


      if(userErrorMsg.isEmpty)
      signIn(type);
    } else if (type != "email") {
      signIn(type);
    }
  }

  void signIn(String type) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthViewModel>(context, listen: false)
          .emailSignIn(_email.trim(), _password);
      new Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(context).pop();
        widget.onSuccess();
      });


    } catch (e) {
      try {
        setState(() {
          _isLoading = false;
          error = e["code"];
          if (error == "ERROR_USER_NOT_FOUND")
            userErrorMsg= "User doesn't exist. Try again.";
          else if (error == "ERROR_WRONG_PASSWORD")
            userErrorMsg = "Password entered is incorrect.";
          else userErrorMsg = error;
        });
      } catch (_) {
        setState(() {
          _isLoading = false;
          error = e.code;


          if (error== "ERROR_USER_NOT_FOUND")
          userErrorMsg= "User doesn't exist. Try again.";
          else if (error == "ERROR_WRONG_PASSWORD")
          userErrorMsg = "Password entered is incorrect.";
          else userErrorMsg = error;


        });
      }
      if (type == "email") {
        final form = formKey.currentState;
        form.validate();
      }
    }
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.only(top: 0.10),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.75,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Log In",
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
                      // validator: (value) {
                      //   // if (value.isEmpty)
                      //   //   return "Please enter your Email";
                      //   // else if (!value.contains("@") ||
                      //   //     error == "ERROR_INVALID_EMAIL")
                      //   //   return "Please enter a valid Email.";
                      //   // else if (error == "ERROR_USER_NOT_FOUND")
                      //   //   return "User doesn't exist. Try again.";
                      //   // return null;
                      // },
                      onChanged: (value){
                        setState(() {
                          _email = value;
                        });

                      },
                      inputAction: TextInputAction.next,
                      onSaved: (value) => _email = value,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    height: 33,
                    child: TextFields(
                      readOnly: _isLoading,
                      hintText: "Password",
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),

                      type: "password",
                      prefixIcon: CertifyIcon.password_signin_1,
                      // validator: (value) {
                      //   if (value.isEmpty)
                      //     return 'Please enter your Password.';
                      //   else if (error == "ERROR_WRONG_PASSWORD")
                      //     return "Password entered is incorrect.";
                      //   return null;
                      // },
                      onChanged: (val){
                        if(val != null) {
                          setState(() {
                            _password = val;
                          });
                        }

                      },
                      onSubmit: (val) {
                        _validateAndSubmit("email");
                      },
                      onSaved: (value) => _password = value,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  userErrorMsg.isNotEmpty
                      ? Column(
                    children: [
                      validationError(userErrorMsg: userErrorMsg),
                    ],
                  )
                      : Container(),
                  SizedBox(height: 10.0),
                  FractionallySizedBox(
                    // widthFactor: 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SecondaryButton(
                              label: "Log In",
                              disabled: _email== null ||_password== null || _email.isEmpty||_password.isEmpty,
                              onTap: () {
                                _validateAndSubmit("email");
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
                              "Forgot password?",
                              style: Styles.ratingTextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey),
                            ),
                            onTap: () {
                              widget.changePageViewIndex(1);
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Text("Create Your Account ",
                                  style: Styles.ratingTextStyle(
                                      fontSize: 12,
                                      color: AppColors.grey),),
                              Icon(FontAwesomeIcons.arrowRight , color: Colors.grey,size: 15,)

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
      ),
    );
  }
}

