import 'package:certifyapp/widgets/data_display/text.dart';
import 'package:flutter/material.dart';

///show  App Embedded Error
/// [error] the message we show to the user
class AppEmbeddedError extends StatelessWidget {
  const AppEmbeddedError({
    Key key,
    @required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Texts(
        error,
        color: Theme.of(context).errorColor,
        textAlign: TextAlign.center,
      ),
    );
  }
}
