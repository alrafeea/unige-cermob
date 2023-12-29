import 'package:certifyapp/core/model/search_model.dart';
import 'package:certifyapp/core/viewModels/Auth_view_model.dart';
import 'package:certifyapp/core/viewModels/search_view_model.dart';
import 'package:certifyapp/pages/base/base_view.dart';
import 'package:certifyapp/values/values.dart';
import 'package:certifyapp/widgets/data_display/no_result_widget.dart';
import 'package:certifyapp/widgets/list_builder/horizontal_list_view_builder.dart';
import 'package:certifyapp/widgets/others/app_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  final SearchModel searchModel;

   SearchResultPage({Key key, this.searchModel}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  AuthViewModel authViewModel;
  int allNewsItemShownCount = 5;


  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of(
      context,
    );
    return BaseView<SearchViewModel>(
      onModelReady: (model) {
        model.getSearchResult(widget.searchModel,authViewModel);
      },
      builder: (BuildContext context, SearchViewModel model, Widget child) =>
          AppScaffold(
              isShowAppBar: true,
              appBarTitle: "Search Result",
              baseViewModel: model,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      model.allNewsList.isEmpty?Center(child: NoResultMsg(msg: "No Result Found",)):Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: HorizontalListViewBuilder(
                            allNewsItemShownCount: model.allNewsList.length>5?model.allNewsList.length: allNewsItemShownCount,
                            newsList: model.allNewsList,
                            listKey: "allSearchNewsItem"),
                      ),

                    ],
                  ),
                ),
              )),
    );
  }
}
