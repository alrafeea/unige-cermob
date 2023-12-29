import 'package:cached_network_image/cached_network_image.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/saved_news_view_model.dart';
import 'package:certifyapp/pages/base/base_view.dart';
import 'package:certifyapp/pages/landing/landing_page.dart';
import 'package:certifyapp/pages/my_account/about_us_page.dart';
import 'package:certifyapp/pages/my_account/contact_us_page.dart';
import 'package:certifyapp/uitl/app_dialogs.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/CircularProgress.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  AuthViewModel authViewModel;

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of(
        context);
    return BaseView<SavedNewsViewModel>(
        builder: (BuildContext context, SavedNewsViewModel model,
            Widget child) =>
            Scaffold(
              body: ListView(
                children: [
                  SpaceH24(),
                  if(authViewModel.status == APP_STATUS.AUTHENTICATED)
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.all(Sizes.PADDING_16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyShade7,
                              blurRadius: 8,
                              offset: Offset(4, 8),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(Sizes.RADIUS_10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: authViewModel.userData.photoURL??'',
                                  maxWidthDiskCache: 500,
                                  maxHeightDiskCache: 500,
                                  errorWidget: (_, __, x) {
                                    return LoadImageError();
                                  },

                                  progressIndicatorBuilder:
                                      (BuildContext context, image,
                                      downloadProgress) {
                                    if (downloadProgress == null)
                                      return AppCircularProgressIndicator();
                                    return Center(
                                      child: SizedBox(
                                        width: 40.0,
                                        height: 20.0,
                                        child: CircleProgressBar(
                                          background:
                                          Theme
                                              .of(context)
                                              .primaryColor,
                                          value: downloadProgress.totalSize !=
                                              null
                                              ? downloadProgress.downloaded /
                                              downloadProgress.totalSize
                                              : 0,
                                        ),
                                      ),
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              onError: (_, __) {
                                                return LoadImageError();
                                              }),
                                        ),
                                      ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          authViewModel.userData.displayName ?? '',
                                          style: TextStyle(
                                              fontSize: Sizes.TEXT_SIZE_20,
                                              color: Colors.black),
                                        ),
                                        if(authViewModel.isExpert)
                                        Text(
                                          "( "+(authViewModel.userData.expert.name+"" ?? '') + " )",
                                          textAlign: TextAlign.start,
                                          style: Styles.ratingTextStyle(
                                              // fontWeight: FontWeight
                                              //     .w600,
                                              fontSize: Sizes
                                                  .TEXT_SIZE_16,
                                              color: AppColors
                                                  .greyShade7),
                                        ),
                                        Text(
                                          authViewModel.userData.email,
                                          style: TextStyle(
                                              fontSize: Sizes.TEXT_SIZE_14,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Icon(
                                    EvaIcons.arrowIosForwardOutline,
                                    color: Colors.black,
                                  )

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  SpaceH24(),
                  SpaceH24(),
                  if(authViewModel.status == APP_STATUS.UNAUTHENTICATED)
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: InkWell(
                        onTap: () {
                          AppDialogs.showAuthDialog(
                              context: context,
                              onSuccess: () {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(Sizes.PADDING_16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.greyShade7,
                                blurRadius: 8,
                                offset: Offset(4, 8),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                                Sizes.RADIUS_10),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Log In",
                                      style: TextStyle(
                                          fontSize: Sizes.TEXT_SIZE_14,
                                          color: Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if(authViewModel.status == APP_STATUS.UNAUTHENTICATED)
                    SpaceH24(),
                  // FractionallySizedBox(
                  //   widthFactor: 0.9,
                  //   child: Container(
                  //     padding: EdgeInsets.all(Sizes.PADDING_16),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: AppColors.greyShade7,
                  //           blurRadius: 8,
                  //           offset: Offset(4, 8),
                  //         ),
                  //       ],
                  //       borderRadius: BorderRadius.circular(Sizes.RADIUS_10),
                  //     ),
                  //     child: FractionallySizedBox(
                  //       widthFactor: 0.9,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 "Settings",
                  //                 style: TextStyle(
                  //                     fontSize: Sizes.TEXT_SIZE_14,
                  //                     color: Colors.black),
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SpaceH24(),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      padding: EdgeInsets.all(Sizes.PADDING_16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyShade7,
                            blurRadius: 8,
                            offset: Offset(4, 8),

                          ),
                        ],
                        borderRadius: BorderRadius.circular(Sizes.RADIUS_10),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "Help center",
                                //   style: TextStyle(
                                //       fontSize: Sizes.TEXT_SIZE_14,
                                //       color: Colors.black),
                                // ),
                                // Container(
                                //   margin: EdgeInsets.symmetric(vertical: 8),
                                //   width: MediaQuery
                                //       .of(context)
                                //       .size
                                //       .width * .65,
                                //   height: 0.5,
                                //   color: Color(0xffCCCCCC),
                                // ),
                                InkWell(
                                  onTap: () async{
                                    await Utils.openTermPage();
                                  },
                                  child: Text(
                                    "Terms of service",
                                    style: TextStyle(
                                        fontSize: Sizes.TEXT_SIZE_14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * .65,
                                  height: 0.5,
                                  color: Color(0xffCCCCCC),
                                ),
                                InkWell(
                                  onTap: () async{
                                    await Utils.openPrivacyPage();
                                  },
                                  child: Text(
                                    "Privacy statement",
                                    style: TextStyle(
                                        fontSize: Sizes.TEXT_SIZE_14,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SpaceH24(),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Container(
                      padding: EdgeInsets.all(Sizes.PADDING_16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyShade7,
                            blurRadius: 8,
                            offset: Offset(4, 8),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(Sizes.RADIUS_10),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    NavigationUtils.appNavigator((){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute
                                            (
                                            builder: (
                                                BuildContext context) =>
                                                AboutUsPage(),
                                          ));
                                    });
                                  },
                                  child: Text(
                                    "About Us",
                                    style: TextStyle(
                                        fontSize: Sizes.TEXT_SIZE_14,
                                        color: Colors.black),


                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  width: MediaQuery
                                      .of(context).size.width * .65,
                                  height: 0.5,
                                  color: Color(0xffCCCCCC),
                                ),
                                InkWell(
                                  onTap: (){
                                    NavigationUtils.appNavigator((){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute
                                            (
                                            builder: (
                                                BuildContext context) =>
                                                ContactUsPage(),
                                          ));
                                    });
                                  },
                                  child: Text(
                                    "Contact us",
                                    style: TextStyle(
                                        fontSize: Sizes.TEXT_SIZE_14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  width:
                                      MediaQuery.of(context).size.width * .65,
                                  height: 0.5,
                                  color: Color(0xffCCCCCC),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SpaceH24(),
                  if(authViewModel.status == APP_STATUS.AUTHENTICATED)
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.all(Sizes.PADDING_16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyShade7,
                              blurRadius: 8,
                              offset: Offset(4, 8),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(Sizes.RADIUS_10),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   "About",
                                  //   style: TextStyle(
                                  //       fontSize: Sizes.TEXT_SIZE_14,
                                  //       color: Colors.black),
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(vertical: 8),
                                  //   width: MediaQuery
                                  //       .of(context).size.width * .65,
                                  //   height: 0.5,
                                  //   color: Color(0xffCCCCCC),
                                  // ),
                                  // Text(
                                  //   "Report a problem",
                                  //   style: TextStyle(
                                  //       fontSize: Sizes.TEXT_SIZE_14,
                                  //       color: Colors.black),
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(vertical: 8),
                                  //   width:
                                  //       MediaQuery.of(context).size.width * .65,
                                  //   height: 0.5,
                                  //   color: Color(0xffCCCCCC),
                                  // ),
                                  if(authViewModel.status ==
                                      APP_STATUS.AUTHENTICATED)
                                    InkWell(
                                      onTap: () async {
                                        // ignore: unnecessary_statements
                                        Provider.of<AuthViewModel>(
                                            context, listen: false).signOut();
                                        NavigationUtils.appNavigator(() {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute
                                                (
                                                builder: (
                                                    BuildContext context) =>
                                                    LandingPage(url: null,
                                                      preventListeningToSharing: true,),
                                              ),
                                                  (Route<dynamic> r) => false);
                                        });
                                      },
                                      child: Text(
                                        "Log Out",
                                        style: TextStyle(
                                            fontSize: Sizes.TEXT_SIZE_14,
                                            color: Colors.black),
                                      ),
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  SpaceH36(),

                ],
              ),
              // baseViewModel: model,
            ));
  }
}

class LoadImageError extends StatelessWidget {
  const LoadImageError({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/profile.png',
        width: 70,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }
}
