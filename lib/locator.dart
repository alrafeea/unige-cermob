import 'package:certifyapp/core/service/news_service.dart';
import 'package:certifyapp/core/viewModels/news_view_model.dart';
import 'package:get_it/get_it.dart';

import 'core/service/saved_news_service.dart';
import 'core/viewModels/my_validated_news_view_model.dart';
import 'core/viewModels/saved_news_view_model.dart';
import 'core/viewModels/search_view_model.dart';

GetIt locator = GetIt.instance;

///di
void setupLocator() {
  /// Services
  locator.registerLazySingleton(() => SavedNewsService());
  locator.registerLazySingleton(() => NewsService());

  /// View Model
  locator.registerFactory(() => SavedNewsViewModel());
  locator.registerFactory(() => NewsViewModel());
  locator.registerFactory(() => SearchViewModel());
  locator.registerFactory(() => MyValidatedNewsViewModel());
}
