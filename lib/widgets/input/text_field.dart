import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/icon/gradient_Icon.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

final _mobileFormatter = NumberTextInputFormatter();

class TextFields extends StatefulWidget {
  TextFields(
      {Key key,
      this.type,
      this.hintText,
      this.suffixIcon,
      this.autoFocus,
      this.onChanged,
      this.initialValue,
      this.minLines,
      this.maxLines,
      this.inputFormatters,
      this.padding,
      this.focus = false,
      this.maxLengthEnforced = true,
      this.suffixIconColor,
      this.inputAction,
      this.onSubmit,
      this.keepPadding = true,
      this.textCapitalization = TextCapitalization.none,
      this.onTap,
      this.controller,
      this.keyboardType,
      this.validator,
      this.borderOnlyError = false,
      this.onSaved,
      this.onSuffixTap,
      this.readOnly: false,
      this.maxLength,
      this.prefixIcon,
      this.bare = false,
      this.fontSize = 12.0,
      this.fontWeight = FontWeight.w700,
      this.autoValidate = false,
      this.onTapTextFields,
      this.textFormFieldRadius = 56.0,
      this.textFormFieldColor, this.initialSize = 33.0})
      : super(key: key);

  final String hintText;
  final String initialValue;
  final String type;
  final bool autoFocus;
  final IconData suffixIcon;
  final Color suffixIconColor;
  final IconData prefixIcon;
  final VoidCallback onTap;
  final Function onTapTextFields;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator validator;
  final Function onSaved;
  final Function onSuffixTap;
  final Function onChanged;
  final Function onSubmit;
  final bool readOnly;
  final int maxLength;
  final int minLines;
  final int maxLines;
  final bool maxLengthEnforced;
  final bool bare;
  final TextInputAction inputAction;
  final double fontSize;
  final FontWeight fontWeight;
  final bool keepPadding;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final bool autoValidate;
  final EdgeInsets padding;
  final bool focus;
  final bool borderOnlyError;
  final double textFormFieldRadius;
  final double initialSize;
  final Color textFormFieldColor;


  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  final FocusNode _focusNode = FocusNode();
  bool focus = false;
  bool view = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        focus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(TextFields oldWidget) {
    if (widget.focus)
      _focusNode.requestFocus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget _buildSuffixIcon() {
    switch (widget.type) {
      case "password":
        {
          return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: view ?
              InkWell(
                      onTap: () {
                        this.setState(() {
                          view = false;
                        });
                      },
                      child: GradientIcon(
                        icon: CertifyIcon.visible_pass,
                        size: 18.0,
                      ),
                    )
                  :
              InkWell(onTap: () {
                this.setState(() {
                  view = true;
                });
              },
                child: Icon(
                    CertifyIcon.invisible_pass, size: 15.0, color: AppColors.primaryColor,),)
          );
        }

        break;
      default:
        if (widget.suffixIcon != null)
          return InkWell(onTap: widget.onSuffixTap,
              child: Icon(widget.suffixIcon, size: 15.0,
                  color: widget.suffixIconColor != null
                      ? widget.suffixIconColor
                      : Colors.grey[500]));
        else
          return null;
    }
  }

  bool _determineReadOnly() {
    if (widget.readOnly != null && widget.readOnly) {
      _focusNode.unfocus();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          // height: (widget.maxLines ?? 1) * widget.initialSize,
          // TODO : return BoxShadow
          decoration: BoxDecoration(
              boxShadow: [
              ],
              // color: Colors.white,
              borderRadius: BorderRadius.circular(
                  widget.bare ? 0.0 : widget.textFormFieldRadius)
          ),
          child: TextFormField(
            onTap: widget.onTapTextFields,
            keyboardAppearance: Theme
                .of(context)
                .brightness,
            scrollPhysics: BouncingScrollPhysics(),
            autovalidate: widget.autoValidate,
            textCapitalization: widget.textCapitalization,
            onFieldSubmitted: widget.inputAction == TextInputAction.next
                ? (widget.onSubmit != null ? widget.onSubmit : (val) {
              _focusNode.nextFocus();
            })
                : widget.onSubmit,
            textInputAction: widget.inputAction,
            minLines: widget.minLines ?? 1,
            maxLines: widget.maxLines ?? 1,
            maxLengthEnforced: widget.maxLengthEnforced,
            initialValue: widget.initialValue,
            onChanged: widget.onChanged,
            focusNode: _focusNode,
            maxLength: widget.maxLength ?? null,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            readOnly: _determineReadOnly(),
            obscureText: widget.type == "password" && !view ? true : false,
            autofocus: widget.autoFocus ?? false,
            validator: widget.validator,
            onSaved: widget.onSaved,
            style: Styles.ratingTextStyle(
              fontSize:widget.fontSize!=null?widget.fontSize: Sizes.TEXT_SIZE_16,
              color: Color(0xFF666666),
            ),
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
                counterText: "",

                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                    color: Color(0xFFCCCCCC),),

                contentPadding: widget.padding != null
                    ? widget.padding
                    : EdgeInsets.symmetric(
                    vertical: 5.0, horizontal: 7),
                filled: true,
                fillColor: widget.bare ? Colors.transparent : widget
                    .textFormFieldColor != null
                    ? widget.textFormFieldColor
                    : AppColors.TextFieldsColor,

                suffixIcon: _buildSuffixIcon(),
                prefixIcon: widget.type != "search" ?
                widget.prefixIcon != null ?
                Icon(widget.prefixIcon, size: 15.0, color: Colors.grey[500])
                    :
                null
                    :
                Icon(EvaIcons.search, size: 15.0, color: Colors.grey[500]),

                errorStyle: TextStyle(fontSize: 14.0,
                    fontWeight: widget.fontWeight,
                    height: widget.borderOnlyError ? 0.0 : null),
                errorMaxLines: 3,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context)
                        .errorColor
                        .withOpacity(widget.bare ? 0.0 : 0.5), width: 0.1),
                    borderRadius: BorderRadius.circular(
                        widget.bare ? 0.0 : widget.textFormFieldRadius)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context)
                        .errorColor
                        .withOpacity(widget.bare ? 0.0 : 0.5), width: 0.1),
                    borderRadius: BorderRadius.circular(
                        widget.bare ? 0.0 : widget.textFormFieldRadius)
                ),
                focusedBorder: widget.bare?UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black
                        .withOpacity(widget.bare ? 1.0 : 1.0), width: 0.3)):OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context)
                        .dividerColor
                        .withOpacity(widget.bare ? 0.0 : 1.0), width: 0.1),
                    borderRadius: BorderRadius.circular(
                        widget.bare ? 0.0 : widget.textFormFieldRadius)
                ),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context)
                        .dividerColor
                        .withOpacity(widget.bare ? 0.0 : 1.0), width: 0.1),
                    borderRadius: BorderRadius.circular(
                        widget.bare ? 0.0 : widget.textFormFieldRadius)
                ),
                enabledBorder: widget.bare?UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black
                        .withOpacity(widget.bare ? 1.0 : 1.0), width: 0.2)):OutlineInputBorder(
                    borderSide: BorderSide(color: Theme
                        .of(context)
                        .dividerColor
                        .withOpacity(widget.bare ? 0.0 : 1.0), width: 0.1),
                    borderRadius: BorderRadius.circular(
                        widget.bare ? 0.0 : widget.textFormFieldRadius)
                )

            ),
          ),
        )
    );
  }
}
