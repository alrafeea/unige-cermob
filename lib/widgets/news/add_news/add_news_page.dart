import 'package:certifyapp/core/model/post/news_model.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/news_view_model.dart';
import 'package:certifyapp/pages/adaptive.dart';
import 'package:certifyapp/pages/base/base_view.dart';
import 'package:certifyapp/pages/news_validating/add_validation.dart';
import 'package:certifyapp/pages/news_validating/show_validations.dart';
import 'package:certifyapp/uitl/app_dialogs.dart';
import 'package:certifyapp/uitl/navigation_utils.dart';
import 'package:certifyapp/uitl/utils.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/buttons/secondary_button.dart';
import 'package:certifyapp/widgets/input/text_field.dart';
import 'package:certifyapp/widgets/link_preview/Vertical_Flutter_Link_Preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddNewsPage extends StatefulWidget {
  final String url;
  final Function changeCurrentTab;
  final NewsModel addNews;
  final TextEditingController urlController;
  const AddNewsPage(
      {Key key,
      this.url,
      this.changeCurrentTab,
      this.addNews,
      this.urlController})
      : super(key: key);

  @override
  _AddNewsPageState createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  // TextEditingController urlController = TextEditingController();
  AuthViewModel authViewModel;
  final formKey = GlobalKey<FormState>();
  bool isAddLoading = false;
  bool isShowLoading = false;
  bool isShowDetailsLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of(context, listen: true);

    // widget.urlController.text = widget.addNews.url != null
    //     ? Utils.getUrlWithOutQueryParams(url: widget.addNews.url)
    //     : null;
    widget.addNews.counters =
        Counters(usersValidations: 0, expertsValidations: 0);
    return BaseView<NewsViewModel>(
        onModelReady: (_) {},
        builder: (_, model, w) => Scaffold(
                body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        if (widget.addNews.url != null)
                          Container(
                            height:
                                assignHeight(context: context, fraction: 0.35),
                            child: VerticalFlutterLinkPreview(
                              hasBgColor: false,
                              imageWidthFraction: 0.9,
                              imageHeightFraction: Utils.isSocialMediaLinks(
                                      url: widget.addNews.url)
                                  ? 0.255
                                  : 0.225,
                              titleMaxLines: 3,
                              post: widget.addNews,
                            ),
                          ),
                        SizedBox(height: 20),

                        Container(
                          margin: EdgeInsets.only(left: 0, right: 0, top: 0),
                          child: TextFields(
                              hintText: "Add article URL",
                              fontSize: 13.5,
                              maxLines: 5,
                              minLines: 2,
                              textFormFieldColor: Colors.white,
                              onSubmit: (_) async {
                                await checkUrl(onSuccess: () {});
                              },
                              readOnly: widget.url != null,
                              controller: widget.urlController,
                              fontWeight: FontWeight.w600,
                              padding: EdgeInsets.only(top: 10,bottom: 8,left: 25,right: 25),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null || value == '')
                                  return "Please enter the article URL";
                                else
                                  return null;
                              }),
                        ),

                        SizedBox(height: 12),
                        // if (widget.addNews.url != null)
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: SecondaryButton(
                                      label: "Add Validation",
                                      disabled: isAddLoading,
                                      loading: isAddLoading,
                                      onTap: () async {
                                        setState(() {
                                          isAddLoading = true;
                                        });
                                        await checkUrl(onSuccess: () {
                                          widget.addNews.id =
                                              Utils.encryptStringByAES(
                                                  string: widget.addNews.url);
                                          new Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            model.getNewsById(
                                                widget.addNews, authViewModel,
                                                onSuccess: (news, isUpdating) {
                                              NavigationUtils.appNavigator(() {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        AddValidationPage(
                                                      isUpdating: isUpdating,
                                                      newsInfo: news,
                                                    ),
                                                  ),
                                                );
                                              });
                                            });
                                          });
                                        });
                                      }),
                                  width: assignWidth(
                                      context: context, fraction: 0.75),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: SecondaryButton(
                                    label: "Show Validation",
                                    disabled: isShowLoading,
                                    loading: isShowLoading,
                                    onTap: () async {
                                      setState(() {
                                        isShowLoading = true;
                                      });

                                      await checkUrl(onSuccess: () {
                                        widget.addNews.id =
                                            Utils.encryptStringByAES(
                                                string: widget.addNews.url);
                                        new Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {

                                          model.getNewsById(
                                              widget.addNews, authViewModel,
                                              onSuccess: (news, isUpdating) {
                                            NavigationUtils.appNavigator(() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ShowValidationPage(
                                                    newsInfo: news,
                                                    isUpdating: isUpdating,
                                                  ),
                                                ),
                                              );
                                            });
                                          });
                                        });
                                      });
                                    }),
                                width: assignWidth(
                                    context: context, fraction: 0.75),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  _setUrl(
      {String url,
      NewsModel addNewsModel,
      TextEditingController urlController,
      bool isSetSateTrue = false}) {
    if (url != null && Uri.parse(url).isAbsolute) {
      urlController.text = url;
      var uri = Uri.parse(url);
      addNewsModel.url = urlController.text;
      addNewsModel.source = uri.host;
      if (isSetSateTrue) {
        setState(() {});
      }
    }
  }

  checkUrl({Function onSuccess}) async {
    String requestedUrl =
        Utils.getUrlWithOutQueryParams(url: widget.urlController.text.trim());
    widget.urlController.text = requestedUrl;
    if (formKey.currentState.validate()) {
      try {
        final response = await http.get(requestedUrl);

        if (response.statusCode == 200) {
          var uri = Uri.parse(requestedUrl);
          print(uri.queryParameters);
          setState(() {
            widget.addNews.url =
                Utils.getUrlWithOutQueryParams(url: requestedUrl);
            widget.addNews.source = uri.host;
            widget.addNews.counters =
                Counters(usersValidations: 0, expertsValidations: 0);
          });
          if (authViewModel.status == APP_STATUS.UNAUTHENTICATED) {
            AppDialogs.showAuthDialog(
                context: context,
                onSuccess: () {
                  onSuccess();
                  stopLoaders();
                });
          } else {
            onSuccess();
            stopLoaders();
          }
        } else {
          stopLoaders();
          Utils.showErrorToast("this link not exist");
        }
      } catch (e) {
        stopLoaders();
        Utils.showErrorToast('Invalid URL!');
      }
    } else {
      stopLoaders();
    }
  }

  stopLoaders() {
    setState(() {
      isShowLoading = false;
      isAddLoading = false;
      isShowDetailsLoading = false;
    });
  }
}
