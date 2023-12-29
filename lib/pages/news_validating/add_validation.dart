import 'package:certifyapp/core/enum/viewstate.dart';
import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/model/post/reviews/expert_review_model.dart';
import 'package:certifyapp/core/model/post/reviews/type_model.dart';
import 'package:certifyapp/core/model/post/reviews/user_review_model.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/news_view_model.dart';
import 'package:certifyapp/pages/landing/landing_page.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/catalog_widget/spaces.dart';
import 'package:certifyapp/widgets/data_display/cards/rating_item.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:certifyapp/widgets/link_preview/Vertical_Flutter_Link_Preview.dart';
import 'package:certifyapp/widgets/news/Icons/home_icon.dart';
import 'package:certifyapp/widgets/news/Icons/saved_news.dart';
import 'package:certifyapp/widgets/news/Icons/share_post.dart';
import 'package:certifyapp/widgets/others/app_scaffold_widget.dart';
import 'package:certifyapp/widgets/progress_indicator/app_circular_progress_Indeicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../adaptive.dart';
import '../base/base_view.dart';

// ignore: must_be_immutable
class   AddValidationPage extends StatefulWidget {
  final NewsModel newsInfo;
  final bool isUpdating;

  AddValidationPage({Key key, this.newsInfo, this.isUpdating = false})
      : super(key: key);

  @override
  _AddValidationPageState createState() => _AddValidationPageState();
}

class _AddValidationPageState extends State<AddValidationPage> {
  TextEditingController claimController = new TextEditingController();
  AuthViewModel authViewModel;
  TextEditingController whatIsTrueController = new TextEditingController();

  TextEditingController whatIsFalseController = new TextEditingController();

  RatingKey selectedRatingKey;
  RatingKey oldSelectedRatingKey;
  bool hasOldValidation = false;
  bool isLoadingFinished = false;

  // bool selectedRatingKey;

  ExpertReviewModel expertReviewModel = ExpertReviewModel() ;
  UserReviewModel userReviewModel =UserReviewModel();

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of(
      context,
    );
    return BaseView<NewsViewModel>(
      onModelReady: (model)async {
        if(widget.isUpdating) {
          if (authViewModel.isExpert) {
            model.getNewsExpertReviews(widget.newsInfo);
          }else{
            model.getNewsUserReviews(widget.newsInfo);
          }
        }
        new Future.delayed(const Duration(milliseconds: 250), () {

          bool isInMyValidation = authViewModel.userData.myValidatedNews == null?false:
          authViewModel.userData.myValidatedNews.contains(widget.newsInfo.id);
          if (widget.isUpdating || isInMyValidation) {
            if (authViewModel.isExpert) {
                model.expertReviewsList.forEach((element) {
                  if (element.user.uid == authViewModel.userData.uid) {
                    selectedRatingKey =
                        RatingUtils.getRatingKeyById(element.type.id);
                    oldSelectedRatingKey = selectedRatingKey;
                    hasOldValidation = true;
                    claimController.text = element.claims.length>0?element.claims[0]:'';
                    whatIsTrueController.text = element.whatIsTrue ?? '';
                    whatIsFalseController.text = element.whatIsFalse ?? '';
                    expertReviewModel.id = element.id;
                  }
                });
                isLoadingFinished = true;
            } else {
              model.userReviewsList.forEach((element) {
                if (element.user.uid == authViewModel.userData.uid) {
                  userReviewModel.id = element.id;
                  selectedRatingKey =
                      RatingUtils.getRatingKeyById(element.type.id);
                  oldSelectedRatingKey = selectedRatingKey;
                  hasOldValidation = true;
                }
              });

              isLoadingFinished = true;
            }


          }
        }
        );

      },
      builder: (BuildContext context, NewsViewModel model, Widget child) =>
          AppScaffold(
            isShowAppBar: true,
        appBarTitle: "Validating",
        baseViewModel: model,
        appBarActions: <Widget>[
          SharePostIcon(
            post: widget.newsInfo,
          ),
          if (widget.isUpdating) SavedNewsIcon(news: widget.newsInfo),
          HomeIcon(),
        ],
        body:model.state == ViewState.Busy
            ? AppCircularProgressIndicator() : Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_16),
          child: Container(
            height: assignHeight(context: context, fraction: 1),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.95,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(

                        height: assignHeight(context: context, fraction: 0.35),
                        child: VerticalFlutterLinkPreview(
                          hasBgColor: false,
                          imageWidthFraction: 0.9,
                          imageHeightFraction:Utils.isSocialMediaLinks(url: widget.newsInfo.url)?0.255: 0.225,
                          titleMaxLines: 3,
                          fontSize: 16,
                          post: widget.newsInfo,
                        ),
                      ),
                    ),
                    SpaceH12(),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rating",
                              style: Styles.ratingTextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: Sizes.TEXT_SIZE_24,
                                color: Color(0xFF313133),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SpaceH12(),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedRatingKey =
                                              RatingKey.MostlyFalse;
                                        });
                                      },
                                      child: RatingItem(
                                        ratingKey: RatingKey.MostlyFalse,
                                        isActive: selectedRatingKey ==
                                            RatingKey.MostlyFalse,
                                      )),
                                  SpaceH12(),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedRatingKey = RatingKey.False;
                                        });
                                      },
                                      child: RatingItem(
                                        ratingKey: RatingKey.False,
                                        isActive: selectedRatingKey ==
                                            RatingKey.False,
                                      )),
                                  SpaceH12(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey = RatingKey.Unproven;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.Unproven,
                                      isActive: selectedRatingKey ==
                                          RatingKey.Unproven,
                                    ),
                                  ),
                                  SpaceH12(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey =
                                            RatingKey.Miscaptioned;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.Miscaptioned,
                                      isActive: selectedRatingKey ==
                                          RatingKey.Miscaptioned,
                                    ),
                                  ),
                                  SpaceH12(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey = RatingKey.Scam;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.Scam,
                                      isActive:
                                          selectedRatingKey == RatingKey.Scam,
                                    ),
                                  ),
                                  SpaceH12(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey =
                                            RatingKey.MostlyTrue;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.MostlyTrue,
                                      isActive: selectedRatingKey ==
                                          RatingKey.MostlyTrue,
                                    ),
                                  ),
                                  SpaceH12(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey = RatingKey.True;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.True,
                                      isActive:
                                          selectedRatingKey == RatingKey.True,
                                    ),
                                  ),
                                  SpaceH12(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey = RatingKey.MixMix;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.MixMix,
                                      isActive:
                                          selectedRatingKey == RatingKey.MixMix,
                                    ),
                                  ),
                                  SpaceH12(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey = RatingKey.Outdated;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.Outdated,
                                      isActive: selectedRatingKey ==
                                          RatingKey.Outdated,
                                    ),
                                  ),
                                  SpaceH12(),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedRatingKey = RatingKey.Rumour;
                                      });
                                    },
                                    child: RatingItem(
                                      ratingKey: RatingKey.Rumour,
                                      isActive:
                                          selectedRatingKey == RatingKey.Rumour,
                                    ),
                                  ),
                                  SpaceH12(),
                                ],
                              ),
                            ],
                          ),
                          SpaceH36(),
                          if (authViewModel.isExpert)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Claim",
                                  style: Styles.ratingTextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: Sizes.TEXT_SIZE_18,
                                    color: Color(0xFF313133),
                                  ),
                                ),
                                SpaceH4(),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 0, right: 2, top: 0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greyShade7,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: TextFields(
                                      textFormFieldColor: AppColors.TextFieldsColor,
                                      textFormFieldRadius: 12,
                                      hintText: "Add Your Claim",
                                      minLines: 2,
                                      maxLines: 30,
                                      controller: claimController,
                                      fontWeight: FontWeight.w600,
                                      padding: EdgeInsets.all(Sizes.PADDING_22),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value == null ||
                                            value == '' ||
                                            !Uri.parse(value).isAbsolute)
                                          return "Please add Claim";
                                        else
                                          return null;
                                      }),
                                ),
                                SpaceH24(),
                                Text(
                                  "What’s true",
                                  style: Styles.ratingTextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: Sizes.TEXT_SIZE_18,
                                    color: Color(0xFF313133),
                                  ),
                                ),
                                SpaceH4(),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, right: 2, top: 0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greyShade7,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: TextFields(
                                      textFormFieldColor: AppColors.TextFieldsColor,
                                      textFormFieldRadius: 12,
                                      hintText:
                                          "Add what’s true about the news",
                                      minLines: 2,
                                      maxLines: 30,
                                      controller: whatIsTrueController,
                                      fontWeight: FontWeight.w600,
                                      padding: EdgeInsets.all(Sizes.PADDING_22),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value == null ||
                                            value == '' ||
                                            !Uri.parse(value).isAbsolute)
                                          return "Please add Claim";
                                        else
                                          return null;
                                      }),
                                ),
                                SpaceH24(),                                Text(
                                  "What’s false",
                                  style: Styles.ratingTextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: Sizes.TEXT_SIZE_18,
                                    color: Color(0xFF313133),
                                  ),
                                ),
                                SpaceH4(),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, right: 2, top: 0),
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.RADIUS_40), topRight: Radius.circular(Sizes.RADIUS_40)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greyShade7,
                                        blurRadius: 8,
                                        // offset: Offset(1, 1), // Shadow position
                                      ),
                                    ],
                                  ),
                                  child: TextFields(
                                      textFormFieldColor: AppColors.TextFieldsColor,
                                      textFormFieldRadius: 12,


                                      hintText:
                                          "Add What’s false about the news",
                                      
                                      minLines: 2,
                                      maxLines: 30,
                                      controller: whatIsFalseController,
                                      fontWeight: FontWeight.w600,
                                      padding: EdgeInsets.all(Sizes.PADDING_22),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value == null ||
                                            value == '' ||
                                            !Uri.parse(value).isAbsolute)
                                          return "Please add Claim";
                                        else
                                          return null;
                                      }),
                                ),
                                SpaceH48(),
                                SpaceH12(),
                              ],
                            ),
                          SpaceH12(),
                        ],
                      ),
                    ),
                    SpaceH12(),
                    SpaceH12()
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
            border: Border.all(
                color: HexColor('#707070'),
                width: 0),
          ),
          // color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.1,
          child: ListView(
            children: [
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SecondaryButton(
                          label: "Submit",
                          fontSize: 17,
                          loading: model.state == ViewState.BusyLocal,
                          onTap: () async {
                            // if (formKey.currentState.validate()) {
                            submitValidation(model);
                          }
                          // },
                          ),
                      width: assignWidth(context: context, fraction: 0.70),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  submitValidation(NewsViewModel model) async {
    if(selectedRatingKey == null) {
      Utils.showErrorToast("You have to select rating");
    } else {
      if (authViewModel.isExpert) {
        if (oldSelectedRatingKey != selectedRatingKey) {
          setExpertRating();
        }
        if(!hasOldValidation) {
          if(widget.newsInfo.counters.expertsValidations == null){
            widget.newsInfo.counters.expertsValidations = 0;
          }
          widget.newsInfo.counters.expertsValidations++;
        }

        expertReviewModel.type =
            Type(id: selectedRatingKey.getRatingInof().key);
        expertReviewModel.claims = [];
        expertReviewModel.claims.add(claimController.text.trim());
        expertReviewModel.whatIsFalse = whatIsFalseController.text.trim();
        expertReviewModel.whatIsTrue = whatIsTrueController.text.trim();
        expertReviewModel.expert = authViewModel.userData.expert;
        expertReviewModel.user = User(
            photoURL: authViewModel.userData.photoURL,
            uid: authViewModel.userData.uid,
            displayName: authViewModel.userData.displayName,
            email: authViewModel.userData.email);
      } else {
        if (oldSelectedRatingKey != selectedRatingKey) {
          setUserRating();
        }

        if(!hasOldValidation) {
          if(widget.newsInfo.counters.usersValidations == null){
            widget.newsInfo.counters.usersValidations = 0;
          }
          widget.newsInfo.counters.usersValidations++;
        }

        userReviewModel.type = Type(id: selectedRatingKey
            .getRatingInof()
            .key);
        userReviewModel.user = User(
            photoURL: authViewModel.userData.photoURL,
            uid: authViewModel.userData.uid,
            displayName: authViewModel.userData.displayName,
            email: authViewModel.userData.email);
      }

      await model.updateNews(
          news: widget.newsInfo,
          isExpert: authViewModel.isExpert,
          isUpdating: widget.isUpdating,
          userReviewModel: userReviewModel,
          expertReviewModel: expertReviewModel, );

      if (model.state == ViewState.Idle) {
        if(authViewModel.userData.myValidatedNews ==null)
          authViewModel.userData.myValidatedNews =[];
        if (!authViewModel.userData.myValidatedNews.contains(
            widget.newsInfo.id)) {
          authViewModel.userData.myValidatedNews.add(widget.newsInfo.id);
        }
        if(!widget.isUpdating) {
          if(authViewModel.userData.myNews ==null)
            authViewModel.userData.myNews =[];
          authViewModel.userData.myNews.add(widget.newsInfo.id);
        }
         authViewModel.updateUserData(authViewModel.userData.toJson());

        Utils.showSuccessCustomAppToast(msg:"Validation added successfully ");


        NavigationUtils.appNavigator(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LandingPage(url: null,preventListeningToSharing: true,),
              ),
                  (Route<dynamic> r) => false);
        });
      }
    }

  }

  setUserRating() {
    switch (selectedRatingKey) {
      case RatingKey.True:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter = RatingCounter();
        widget.newsInfo.userRatingCounter.trueRating == null
            ? widget.newsInfo.userRatingCounter.trueRating = 1
            : widget.newsInfo.userRatingCounter.trueRating++;
        break;
      case RatingKey.MostlyTrue:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter = RatingCounter();
        widget.newsInfo.userRatingCounter.mostlyTrue == null
            ? widget.newsInfo.userRatingCounter.mostlyTrue = 1
            : widget.newsInfo.userRatingCounter.mostlyTrue++;
        break;
      case RatingKey.False:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.falseRating ==
            null
            ? widget.newsInfo.userRatingCounter.falseRating = 1
            : widget.newsInfo
            .userRatingCounter.falseRating++;
        break;
      case RatingKey.MostlyFalse:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.mostlyFalse ==
            null
            ? widget.newsInfo.userRatingCounter.mostlyFalse = 1
            : widget.newsInfo
            .userRatingCounter.mostlyFalse++;
        break;
      case RatingKey.MixMix:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.mixMix ==
            null
            ? widget.newsInfo.userRatingCounter.mixMix = 1
            : widget.newsInfo
            .userRatingCounter.mixMix++;
        break;
      case RatingKey.Outdated:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.outdated ==
            null
            ? widget.newsInfo.userRatingCounter.outdated = 1
            : widget.newsInfo
            .userRatingCounter.outdated++;
        break;
      case RatingKey.Scam:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.scam ==
            null
            ? widget.newsInfo.userRatingCounter.scam = 1
            : widget.newsInfo
            .userRatingCounter.scam++;
        break;
      case RatingKey.Miscaptioned:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.miscaptioned ==
            null
            ? widget.newsInfo.userRatingCounter.miscaptioned = 1
            : widget.newsInfo
            .userRatingCounter.miscaptioned++;
        break;
      case RatingKey.Rumour:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.rumour ==
            null
            ? widget.newsInfo.userRatingCounter.rumour = 1
            : widget.newsInfo
            .userRatingCounter.rumour++;
        break;
      case RatingKey.Unproven:
        if (widget.newsInfo.userRatingCounter == null)
          widget.newsInfo.userRatingCounter =
              RatingCounter();
        widget.newsInfo.userRatingCounter.unproven ==
            null
            ? widget.newsInfo.userRatingCounter.unproven = 1
            : widget.newsInfo
            .userRatingCounter.unproven++;
        break;
    }


    if(oldSelectedRatingKey !=  selectedRatingKey) {
      switch (oldSelectedRatingKey) {
        case RatingKey.True:
          widget.newsInfo.userRatingCounter.trueRating == 1
              ? widget.newsInfo.userRatingCounter.trueRating = null
              : widget.newsInfo.userRatingCounter.trueRating--;
          break;
        case RatingKey.MostlyTrue:
          widget.newsInfo.userRatingCounter.mostlyTrue == 1
              ? widget.newsInfo.userRatingCounter.mostlyTrue = null
              : widget.newsInfo.userRatingCounter.mostlyTrue--;
          break;
        case RatingKey.False:

          widget.newsInfo.userRatingCounter.falseRating ==
              1
              ? widget.newsInfo.userRatingCounter.falseRating = null
              : widget.newsInfo
              .userRatingCounter.falseRating--;
          break;
        case RatingKey.MostlyFalse:

          widget.newsInfo.userRatingCounter.mostlyFalse ==
              1
              ? widget.newsInfo.userRatingCounter.mostlyFalse = null
              : widget.newsInfo
              .userRatingCounter.mostlyFalse--;
          break;
        case RatingKey.MixMix:
          widget.newsInfo.userRatingCounter.mixMix ==
              1
              ? widget.newsInfo.userRatingCounter.mixMix = null
              : widget.newsInfo
              .userRatingCounter.mixMix--;
          break;
        case RatingKey.Outdated:
          widget.newsInfo.userRatingCounter.outdated ==
              1
              ? widget.newsInfo.userRatingCounter.outdated = null
              : widget.newsInfo
              .userRatingCounter.outdated--;
          break;
        case RatingKey.Scam:

          widget.newsInfo.userRatingCounter.scam ==
              1
              ? widget.newsInfo.userRatingCounter.scam = null
              : widget.newsInfo
              .userRatingCounter.scam--;
          break;
        case RatingKey.Miscaptioned:

          widget.newsInfo.userRatingCounter.miscaptioned ==
              1
              ? widget.newsInfo.userRatingCounter.miscaptioned = null
              : widget.newsInfo
              .userRatingCounter.miscaptioned++;
          break;
        case RatingKey.Rumour:
          widget.newsInfo.userRatingCounter.rumour ==
              1
              ? widget.newsInfo.userRatingCounter.rumour = null
              : widget.newsInfo
              .userRatingCounter.rumour++;
          break;
        case RatingKey.Unproven:

          widget.newsInfo.userRatingCounter.unproven ==
              1
              ? widget.newsInfo.userRatingCounter.unproven = null
              : widget.newsInfo
              .userRatingCounter.unproven--;
          break;
      }
    }
  }

  setExpertRating() {
    switch (selectedRatingKey) {
      case RatingKey.True:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.trueRating ==
            null
            ? widget.newsInfo.expertRatingCounter.trueRating = 1
            : widget.newsInfo
            .expertRatingCounter.trueRating++;
        break;
      case RatingKey.MostlyTrue:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.mostlyTrue ==
            null
            ? widget.newsInfo.expertRatingCounter.mostlyTrue = 1
            : widget.newsInfo
            .expertRatingCounter.mostlyTrue++;
        break;
      case RatingKey.False:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.falseRating ==
            null
            ? widget.newsInfo.expertRatingCounter.falseRating = 1
            : widget.newsInfo
            .expertRatingCounter.falseRating++;
        break;
      case RatingKey.MostlyFalse:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.mostlyFalse ==
            null
            ? widget.newsInfo.expertRatingCounter.mostlyFalse = 1
            : widget.newsInfo
            .expertRatingCounter.mostlyFalse++;
        break;
      case RatingKey.MixMix:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.mixMix ==
            null
            ? widget.newsInfo.expertRatingCounter.mixMix = 1
            : widget.newsInfo
            .expertRatingCounter.mixMix++;
        break;
      case RatingKey.Outdated:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.outdated ==
            null
            ? widget.newsInfo.expertRatingCounter.outdated = 1
            : widget.newsInfo
            .expertRatingCounter.outdated++;
        break;
      case RatingKey.Scam:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.scam ==
            null
            ? widget.newsInfo.expertRatingCounter.scam = 1
            : widget.newsInfo
            .expertRatingCounter.scam++;
        break;
      case RatingKey.Miscaptioned:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.miscaptioned ==
            null
            ? widget.newsInfo.expertRatingCounter.miscaptioned = 1
            : widget.newsInfo
            .expertRatingCounter.miscaptioned++;
        break;
      case RatingKey.Rumour:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.rumour ==
            null
            ? widget.newsInfo.expertRatingCounter.rumour = 1
            : widget.newsInfo
            .expertRatingCounter.rumour++;
        break;
      case RatingKey.Unproven:
        if (widget.newsInfo.expertRatingCounter == null)
          widget.newsInfo.expertRatingCounter =
              RatingCounter();
        widget.newsInfo.expertRatingCounter.unproven ==
            null
            ? widget.newsInfo.expertRatingCounter.unproven = 1
            : widget.newsInfo
            .expertRatingCounter.unproven++;
        break;
    }


    if(oldSelectedRatingKey !=  selectedRatingKey) {
      switch (oldSelectedRatingKey) {
        case RatingKey.True:
          widget.newsInfo.expertRatingCounter.trueRating ==
              1
              ? widget.newsInfo.expertRatingCounter.trueRating = null
              : widget.newsInfo
              .expertRatingCounter.trueRating--;
          break;
        case RatingKey.MostlyTrue:
          widget.newsInfo.expertRatingCounter.mostlyTrue ==
              1
              ? widget.newsInfo.expertRatingCounter.mostlyTrue = null
              : widget.newsInfo
              .expertRatingCounter.mostlyTrue--;
          break;
        case RatingKey.False:
          widget.newsInfo.expertRatingCounter.falseRating ==
              1
              ? widget.newsInfo.expertRatingCounter.falseRating = null
              : widget.newsInfo
              .expertRatingCounter.falseRating--;
          break;
        case RatingKey.MostlyFalse:
          widget.newsInfo.expertRatingCounter.mostlyFalse ==
              1
              ? widget.newsInfo.expertRatingCounter.mostlyFalse = null
              : widget.newsInfo
              .expertRatingCounter.mostlyFalse--;
          break;
        case RatingKey.MixMix:
          widget.newsInfo.expertRatingCounter.mixMix ==
              1
              ? widget.newsInfo.expertRatingCounter.mixMix = null
              : widget.newsInfo
              .expertRatingCounter.mixMix--;
          break;
        case RatingKey.Outdated:
          widget.newsInfo.expertRatingCounter.outdated ==
              1
              ? widget.newsInfo.expertRatingCounter.outdated = null
              : widget.newsInfo
              .expertRatingCounter.outdated--;
          break;
        case RatingKey.Scam:
          widget.newsInfo.expertRatingCounter.scam ==
              1
              ? widget.newsInfo.expertRatingCounter.scam = null
              : widget.newsInfo
              .expertRatingCounter.scam--;
          break;
        case RatingKey.Miscaptioned:
          widget.newsInfo.expertRatingCounter.miscaptioned ==
              1
              ? widget.newsInfo.expertRatingCounter.miscaptioned = null
              : widget.newsInfo
              .expertRatingCounter.miscaptioned--;
          break;
        case RatingKey.Rumour:
          widget.newsInfo.expertRatingCounter.rumour ==1
              ? widget.newsInfo.expertRatingCounter.rumour =null
              : widget.newsInfo
              .expertRatingCounter.rumour--;
          break;
        case RatingKey.Unproven:
          widget.newsInfo.expertRatingCounter.unproven == 1
              ? widget.newsInfo.expertRatingCounter.unproven = null
              : widget.newsInfo
              .expertRatingCounter.unproven--;
          break;
      }
    }




  }

}

