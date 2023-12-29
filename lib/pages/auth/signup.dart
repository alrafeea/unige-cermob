import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/pages/auth/validationError.dart';
import 'package:certifyapp/uitl/date_uitl.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/dialogs/select_country_dialog.dart';
import 'package:certifyapp/widgets/data_display/dialogs/select_gender_dialog.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  final int currentIndex;
  final Function changePageViewIndex;
  final Function  onSuccess;


  SignUp({Key key, this.currentIndex, this.changePageViewIndex, this.onSuccess}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final signUpKey = GlobalKey<FormState>();

  String _email;
  String _emailError = "";

  String _firstName;

  String _lastName;

  String _password;
  String _rePasswordError = "";
  String _passwordError = "";
  String _rePassword;
  DateTime selectedDateOfBirth;

  bool _isLoading = false;
  bool _isChecked = false;

  String error = "";

  // todo create a model for Country
  // todo use country from the json
  dynamic _selectedCountry = {
    "name": "Switzerland",
    "name_ar": "سويسرا",
    "code": "+41",
    "countryCode": "CH"
  };

  String _selectedGender;

  void _validateAndSubmit(String type) {
    setState(() {
      error = "";
      _emailError = "";
      _rePasswordError = "";
      _passwordError = '';
    });
    final form = signUpKey.currentState;
    if (type == "email" && form.validate()) {
      form.save();

      if (_rePassword != _password)
        _rePasswordError = 'Please Re-Password should match Password.';

      if (!_email.contains("@"))
        _emailError = "Please enter a valid Email.";
      if (_rePasswordError.isEmpty && _emailError.isEmpty) {
        signUp(type);
      }
    } else if (type != "email") {
      signUp(type);
    }
  }

  void signUp(String type) async {
    setState(() { _isLoading = true; });
    try {
      switch (type) {
        case "email":
          await Provider.of<AuthViewModel>(context, listen: false).createAccount(_email.trim(), _password, _firstName.trim(), _lastName.trim(),selectedDateOfBirth,_selectedGender,_selectedCountry['name']);
          new Future.delayed(const Duration(milliseconds: 1500), (){
            Navigator.of(context).pop();
            Utils.showSuccessCustomAppToast(msg:"Account Created Successfully ");
            widget.onSuccess();
          });
          break;
      }
    }
    catch (e) {
      try {
        setState(() {
          _isLoading = false;
          error = e["code"];

          if (_rePassword != _password)
            _rePasswordError = 'Please Re-Password should match Password.';

          if (!_email.contains("@") || error == "ERROR_INVALID_EMAIL")
            _emailError = "Please enter a valid Email.";
          else if (error == "ERROR_EMAIL_ALREADY_IN_USE")
            _emailError = "Email is already in use.";
        });
      } catch (_) {
        setState(() {
          _isLoading = false;
          error = e.code;

          print(_password +_rePassword);
          if (_rePassword != _password)
            _rePasswordError = 'Please Re-Password should match Password.';
          else if (error == "ERROR_WEAK_PASSWORD") {
            _passwordError = 'Please Enter Strong Password';
          }

          if (!_email.contains("@") || error == "ERROR_INVALID_EMAIL")
            _emailError = "Please enter a valid Email.";
          else if (error == "ERROR_EMAIL_ALREADY_IN_USE")
            _emailError = "Email is already in use.";
        });
      }
      if (type=="email") {
        final form = signUpKey.currentState;
        form.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpKey,
      child: Container(
        padding: EdgeInsets.only(top: 0.0),
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
                        "Sign Up",
                        style: Styles.titleTextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.TEXT_SIZE_22),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 33,
                          child: TextFields(
                            readOnly: _isLoading,
                            initialValue: _firstName,
                            hintText: "First Name",
                            prefixIcon: CertifyIcon.user_name,
                            textCapitalization: TextCapitalization.words,
                            borderOnlyError: true,
                            validator: (value) {
                              if (value.isEmpty) return "";
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                _firstName = val;
                              });
                            },
                            inputAction: TextInputAction.next,
                            onSaved: (value) => _firstName = value,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Container(
                          height: 33,
                          child: TextFields(
                            readOnly: _isLoading,
                            initialValue: _lastName,
                            hintText: "Last Name",
                            borderOnlyError: true,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value.isEmpty) return "";
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                _lastName = val;
                              });
                            },
                            inputAction: TextInputAction.next,
                            onSaved: (value) => _lastName = value,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    height: 33,
                    child: TextFields(
                      readOnly: _isLoading,
                      initialValue: _email,
                      hintText: "Email Address",
                      prefixIcon: CertifyIcon.email_signin,
                      type: "email",
                      keyboardType: TextInputType.emailAddress,
                      // validator: (value) {
                      //   if (value.isEmpty)
                      //     return "Please enter your Email";
                      //   else if (!value.contains("@") ||
                      //       error == "ERROR_INVALID_EMAIL")
                      //     return "Please enter a valid Email.";
                      //   else if (error == "ERROR_EMAIL_ALREADY_IN_USE")
                      //     return "Email is already in use.";
                      //   return null;
                      // },
                      inputAction: TextInputAction.next,
                      onSaved: (value) => _email = value,
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                    ),
                  ),
                  if (_emailError.isNotEmpty)
                    validationError(userErrorMsg: _emailError.toString()),
                  SizedBox(height: 12.0),
                  Container(
                    height: 33,
                    child: TextFields(
                      readOnly: _isLoading,
                      hintText: "Password",
                      type: "password",
                      prefixIcon: CertifyIcon.password_signin_1,
                      onChanged: (val) {
                        if(val!=null)
                        setState(() {_password = val;});
                      },
                      onSubmit: (val) {
                        _validateAndSubmit("email");
                      },
                      onSaved: (value) => _password = value,
                    ),
                  ),
                  if (_passwordError.isNotEmpty)
                    validationError(userErrorMsg: _passwordError.toString()),
                  SizedBox(height: 12.0),
                  Container(
                    height: 33,
                    child: TextFields(
                      readOnly: _isLoading,
                      prefixIcon: CertifyIcon.password_signin_1,
                      hintText: "Re-Password",
                      type: "password",
                      onChanged: (val) {
                        if(val!=null)
                        setState(() {
                          _rePassword = val;
                        });
                      },
                      onSaved: (value) => _rePassword = value,
                    ),
                  ),
                  if (_rePasswordError.isNotEmpty)
                    validationError(
                        userErrorMsg:
                            _rePasswordError),
                  SizedBox(height: 12.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 33,
                          child: TextFields(
                            readOnly: true,
                            onTapTextFields: () {
                              showCalender(context);
                            },
                            bare: true,
                            prefixIcon: CertifyIcon.birthdate,
                            hintText: selectedDateOfBirth == null
                                ? "Date of Birth"
                                : "${DateUtil.getDayMonthYearDateFormatted(
                                selectedDateOfBirth)}",
                            textCapitalization: TextCapitalization.words,
                            borderOnlyError: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Container(
                          height: 33,
                          child: TextFields(readOnly: true,
                            prefixIcon: CertifyIcon.gender,
                            bare: true,
                            onTapTextFields: () => selectGenderDialog(),
                            hintText: _selectedGender ?? "Gender",
                            borderOnlyError: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if(selectedDateOfBirth != null && !isSelectedAgeAllow())
                    Column(
                      children: [
                        SizedBox(height: 7,),

                        validationError(
                            userErrorMsg: "To Create an account your age should be +18")
                      ],
                    ),

                  SizedBox(height: 12.0),
                  Container(
                    height: 33,
                    child: TextFields(readOnly: true,
                      prefixIcon: CertifyIcon.country,
                      bare: true,
                      hintText: _selectedCountry == null
                          ? "Country"
                          : _selectedCountry['name'],
                      onTapTextFields: () => selectCountryDialog(),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      new Checkbox(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value;
                            });
                          },
                          activeColor: AppColors.primaryColor),
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 10),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'I have read and accept the ',
                                    style: TextStyle()),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = () async {
                                      await Utils.openTermPage();
                                    },
                                    text: 'Terms and Conditions',
                                    style: TextStyle(color: Colors.blue),
                                ),
                                TextSpan(
                                    text: ' and ',
                                    style: TextStyle()),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                    await Utils.openPrivacyPage();
                                  },
                                  text: 'Privacy Policy',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),

                  if(error.isNotEmpty &&
                      (_rePasswordError.isEmpty && _emailError.isEmpty &&_passwordError.isEmpty))
                    validationError(
                        userErrorMsg: error),


                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SecondaryButton(
                              label: "Sign Up",
                              disabled: !_isChecked ||
                                  (_email == null || _email.isEmpty) ||
                                  (_password == null || _password.isEmpty) ||
                                  (_firstName == null || _firstName.isEmpty) ||
                                  (_lastName == null || _lastName.isEmpty) ||
                                  _selectedGender == null ||
                                  selectedDateOfBirth == null ||
                                  !isSelectedAgeAllow(),
                              onTap: () {
                                _validateAndSubmit("email");
                              }, loading: _isLoading),
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
                          height: 20,
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Text(
                                "Forgot password?",
                                style: Styles.ratingTextStyle(
                                    fontSize: 12, color: AppColors.grey),
                              ),

                            ],
                          ),
                          onTap: () {
                            widget.changePageViewIndex(1);
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

  showCalender(BuildContext context) async {
    Utils.hideKeyboard(context);
    DateTime selectedDate;
    selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        this.selectedDateOfBirth = picked;
      });
    }
  }

  void selectCountryDialog() {
    Utils.hideKeyboard(context);

    showDialog(
      context: context,
      child: SelectCountryDialog(
        selectedCountry: _selectedCountry,
        onValueSelected: (value) {
          setState(() {
            _selectedCountry = value;
          });
        },
      ),
    );
  }

  void selectGenderDialog() {
    Utils.hideKeyboard(context);

    showDialog(
      context: context,
      child: SelectGenderDialog(
        selectedGender: _selectedGender,
        onValueSelected: (value) {
          setState(() {
            _selectedGender = value;
          });
        },
      ),
    );
  }


  isSelectedAgeAllow(){
    bool isAllow = false;

    int years = DateTime.now().year - selectedDateOfBirth.year;
    if (years > 18) {
      isAllow = true;
    }

    return isAllow;
  }
}


