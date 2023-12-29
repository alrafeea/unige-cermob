import 'package:certifyapp/app-icons/certify_icon_icons.dart';
import 'package:certifyapp/core/model/search_model.dart';
import 'package:certifyapp/core/viewModels/saved_news_view_model.dart';
import 'package:certifyapp/pages/base/base_view.dart';
import 'package:certifyapp/pages/search/search_result.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/uitl/rating_utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/data_display/cards/rating_item.dart';
import 'package:certifyapp/widgets/data_display/dialogs/rating_key_dailog.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel = SearchModel();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SavedNewsViewModel>(
      builder: (BuildContext context, SavedNewsViewModel model, Widget child) =>
          Scaffold(
              body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              TextFields(
                hintText: "Search News",
                fontSize: 13.5,
                textFormFieldColor: Colors.white,
                suffixIcon: EvaIcons.search,
                onSuffixTap: () {},
                fontWeight: FontWeight.w600,
                initialSize: 60.0,
                controller: searchController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    CertifyIcon.star_withbg,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: Sizes.MARGIN_10,
                  ),
                  Text("Expert validation"),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.MARGIN_22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        RatingKeyDialog dialog = RatingKeyDialog(
                          title: "Please select expert rating",
                          okFunction: (selectedValue) {
                            setState(
                              () {
                                searchModel.expertRatingModel = selectedValue;
                              },
                            );
                          },
                        );
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return dialog;
                          },
                        );
                      },
                      child: searchModel.expertRatingModel == null
                          ? Row(
                              children: [
                                Text("Any"),
                                Icon(
                                  EvaIcons.arrowDown,
                                  color: Colors.black,
                                  size: 17,
                                ),
                              ],
                            )
                          : RatingItem(
                              ratingKey: RatingUtils.getRatingKeyById(
                                  searchModel.expertRatingModel.key),
                              iconSize: 20,
                              isActive: true),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 8,),

                        SizedBox(
                          width: 10,
                          height: 10,
                          child: Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.values[0],

                              value: searchModel.onlyValidatedPost,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (bool newValue) {
                                setState(() {
                                  searchModel.onlyValidatedPost = newValue;
                                });
                              }),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          'Show only validated results',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    CertifyIcon.person2,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: Sizes.MARGIN_10,
                  ),
                  Text("User validation"),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.MARGIN_22,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        RatingKeyDialog dialog = RatingKeyDialog(
                          title: "Please select user rating",
                          okFunction: (selectedValue) {
                            setState(
                              () {
                                searchModel.userRatingModel = selectedValue;
                              },
                            );
                          },
                        );
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return dialog;
                          },
                        );
                      },
                      child: searchModel.userRatingModel == null
                          ? Row(
                              children: [
                                Text("Any"),
                                Icon(
                                  EvaIcons.arrowDown,
                                  color: Colors.black,
                                  size: 17,
                                ),
                              ],
                            )
                          : RatingItem(
                              ratingKey: RatingUtils.getRatingKeyById(
                                  searchModel.userRatingModel.key),
                              iconSize: 20,
                              isActive: true),
                    ),
                    SizedBox(
                      width: Sizes.MARGIN_10,
                    ),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //         value: searchModel.onlyMyPost,
                    //         activeColor: Theme.of(context).primaryColor,
                    //         onChanged: (bool newValue) {
                    //           setState(() {
                    //             searchModel.onlyMyPost = newValue;
                    //           });
                    //         }),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width * 0.35,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(0.0),
                    //         child: Text('Search only within my posts'),
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
              SizedBox(height: 12),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 0,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Checkbox(
              //           value: false,
              //           activeColor: Theme.of(context).primaryColor,
              //           onChanged: (bool newValue) {
              //             setState(() {
              //               searchModel.expertRatingModel =  null;
              //               searchModel.userRatingModel =  null;
              //               searchModel.onlyMyPost = false;
              //               searchModel.onlyValidatedPost =  false;
              //             });
              //           }),
              //       Text("Reset all parameters"),
              //     ],
              //   ),
              // ),
              SizedBox(height: 20),
              SizedBox(
                height: 10,
              ),
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: SecondaryButton(
                    label: "Search",
                    onTap: () {
                      searchModel.searchText = searchController.text;
                      NavigationUtils.appNavigator(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SearchResultPage(searchModel: searchModel),
                          ),
                        );
                      });
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
      )),
    );
  }
}
