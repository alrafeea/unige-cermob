


import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/viewModels/base_view_model.dart';
import 'package:certifyapp/widgets/errors/app_embedded_error.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkBaseView extends StatefulWidget {
  final BaseViewModel baseViewModel;
  final Widget child;

  NetworkBaseView({Key key, this.baseViewModel, this.child});

  @override
  _NetworkBaseViewState createState() => _NetworkBaseViewState();
}

class _NetworkBaseViewState extends State<NetworkBaseView>{

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildBaseViewWidget(),
    );
  }

  buildBaseViewWidget() {
    switch (widget.baseViewModel.state) {
      case ViewState.ErrorLocal:
      case ViewState.Idle:
      case ViewState.BusyLocal:
        return widget.child;
        break;
      case ViewState.Busy:
        return Container(
          height: MediaQuery.of(context).size.height,

          child:AppCircularProgressIndicator(),
        );
        break;
      case ViewState.Error:
        return Center(
          child: AppEmbeddedError(
            error: widget.baseViewModel.error,
          ),
        );
        break;
    }
  }

}




