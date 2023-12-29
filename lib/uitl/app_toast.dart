import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';

class AppToast {

  /// show long toast message
  /// [message] to show for user
  /// [timeInSeconds] how many second the toast will appear to the user
  /// [toastLength] the time we show the message but should be Toast.LENGTH_SHORT , Toast.LENGTH_LONG
  /// [toastGravity] the position of the toast in the screen
  /// [backgroundColor] the background color of the toast
  /// [textColor] the text color of the toast
  /// [icon] the icon you want include in the toast
  /// [radius] the radius of the toast
  /// [elevation] an overlay color will be applied to indicate elevation.
  /// [imageSize] image size inside the toast
  static void showToast({
    @required String message,
    Toast toastLength,
    int timeInSeconds,
    double fontSize,
    ToastGravity toastGravity,
    Color backgroundColor,
    Color textColor,
    ICON icon,
    int radius,
    int elevation,
    int imageSize,
  }) {
    FlutterFlexibleToast.showToast(
        message: message,
        toastLength: toastLength,
        timeInSeconds: timeInSeconds,
        fontSize: fontSize,
        toastGravity: toastGravity,
        backgroundColor: backgroundColor,
        textColor: textColor,
        icon: icon,
        radius: radius,
        elevation: elevation,
        imageSize: imageSize);
  }

  /// show Success toast message
  /// [message] to show for user
  /// [timeInSeconds] how many second the toast will appear to the user
  /// [toastLength] the time we show the message but should be Toast.LENGTH_SHORT , Toast.LENGTH_LONG
  /// [toastGravity] the position of the toast in the screen
  /// [textColor] the text color of the toast
  /// [radius] the radius of the toast
  /// [elevation] an overlay color will be applied to indicate elevation.
  /// [imageSize] image size inside the toast
  static void showSuccessToast({
    @required String message,
    Toast toastLength = Toast.LENGTH_LONG,
    int timeInSeconds,
    double fontSize = 16,
    ToastGravity toastGravity = ToastGravity.TOP,
    Color textColor = Colors.white,
    int radius,
    int elevation,
    Color backgroundColor,
    int imageSize = 32,
  }) {
    FlutterFlexibleToast.showToast(
        message: message,
        toastLength: toastLength,
        timeInSeconds: timeInSeconds,
        fontSize: fontSize,
        toastGravity: toastGravity,
        backgroundColor: backgroundColor??Colors.green,
        textColor: textColor,
        icon: ICON.SUCCESS,
        radius: radius,
        elevation: elevation,
        imageSize: imageSize);
  }

  /// show Error toast message
  /// [message] to show for user
  /// [timeInSeconds] how many second the toast will appear to the user
  /// [toastLength] the time we show the message but should be Toast.LENGTH_SHORT , Toast.LENGTH_LONG
  /// [toastGravity] the position of the toast in the screen
  /// [textColor] the text color of the toast
  /// [radius] the radius of the toast
  /// [elevation] an overlay color will be applied to indicate elevation.
  /// [imageSize] image size inside the toast
  static void showErrorToast({
    @required String message,
    Toast toastLength = Toast.LENGTH_LONG,
    int timeInSeconds,
    double fontSize = 16,
    ToastGravity toastGravity = ToastGravity.TOP,
    Color textColor = Colors.white,
    Color backgroundColor,
    int radius,
    int elevation,
    int imageSize = 32,
  }) {
    FlutterFlexibleToast.showToast(
        message: message,
        toastLength: toastLength,
        timeInSeconds: timeInSeconds,
        fontSize: fontSize,
        toastGravity: toastGravity,
        backgroundColor: backgroundColor??Colors.red,
        textColor: textColor,
        icon: ICON.CLOSE,
        radius: radius,
        elevation: elevation,
        imageSize: imageSize);
  }

  /// cancel toast
  void cancelToast() {
    FlutterFlexibleToast.cancel();
  }
}
