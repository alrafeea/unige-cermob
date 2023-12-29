import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/viewModels/news_view_model.dart';
import 'package:certifyapp/widgets/data_display/no_result_widget.dart';
import 'package:certifyapp/widgets/data_display/slider/expert_review_manually_controlled_slider.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:flutter/material.dart';

class ShowExpertValidation extends StatelessWidget {
  final NewsViewModel model;

  const ShowExpertValidation({
    Key key, this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    model.state == ViewState.Busy
        ? AppCircularProgressIndicator()
        : model.expertReviewsList.isEmpty
            ? NoResultMsg()
            : ExpertReviewManuallyControlledSlider(reviewList: model.expertReviewsList ,);
  }
}

