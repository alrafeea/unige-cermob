import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/uitl/app_dialogs.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/icon/gradient_Icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedNewsIcon extends StatelessWidget {
  final NewsModel news;
  AuthViewModel authViewModel;
  SavedNewsIcon({Key key, this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    authViewModel =Provider.of<AuthViewModel>(context);

    return InkWell(
        onTap: () => _onSaveNews(context),
        child: authViewModel.isAuthenticated &&
            authViewModel.userData.savedNews !=
                null &&
            authViewModel.userData.savedNews
                .contains(news.id)
            ? GradientIcon(
          icon: CertifyIcon.filled_star,
          size: IconTheme.of(context).size,
        )
            : Icon(
          CertifyIcon.star,
          color: AppColors.iconColor,
        ));
  }

  _onSaveNews(context) {
    if (authViewModel.status == APP_STATUS.UNAUTHENTICATED) {
      AppDialogs.showAuthDialog(
          context: context,
          onSuccess: () {
            if (authViewModel.userData.savedNews == null) {authViewModel.userData.savedNews =[];}

            if (!authViewModel.userData.savedNews.contains(
                news.id)) {
              authViewModel.userData.savedNews.add(news.id);
            } else {
              authViewModel.userData.savedNews.remove(news.id);
            }
            authViewModel.updateUserData(authViewModel.userData.toJson());
          });
    } else {
      if (authViewModel.userData.savedNews == null) {authViewModel.userData.savedNews =[];}
      if (!authViewModel.userData.savedNews.contains(news.id)) {
        authViewModel.userData.savedNews.add(news.id);
      } else {
        authViewModel.userData.savedNews.remove(news.id);
      }
      authViewModel.updateUserData(authViewModel.userData.toJson());
    }
  }
}
