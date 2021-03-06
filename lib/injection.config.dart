// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:http/http.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/news/data/datasources/article_remote_data_source.dart';
import 'features/news/domain/repositories/articles_repository.dart';
import 'features/news/data/repositories/articles_repository_impl.dart';
import 'features/news/domain/repositories/categories_repository.dart';
import 'features/news/data/repositories/categories_repository_impl.dart';
import 'features/news/data/datasources/category_local_data_source.dart';
import 'features/news/domain/usecases/get_articles.dart';
import 'features/news/domain/usecases/get_categories.dart';
import 'core/device/network_info.dart';
import 'features/news/presentation/store/news_store.dart';
import 'injection.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl());
  gh.lazySingleton<Client>(() => registerModule.client);
  gh.lazySingleton<DataConnectionChecker>(
      () => registerModule.connectionChecker);
  gh.lazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(get<DataConnectionChecker>()));
  final sharedPreferences = await registerModule.prefs;
  gh.lazySingleton<SharedPreferences>(() => sharedPreferences);
  gh.lazySingleton<ArticleRemoteDataSource>(
      () => ArticleRemoteDataSourceImpl(get<Client>()));
  gh.lazySingleton<ArticlesRepository>(() => ArticlesRepositoryImpl(
      networkInfo: get<NetworkInfo>(),
      articleRemoteDataSource: get<ArticleRemoteDataSource>()));
  gh.lazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(get<CategoryLocalDataSource>()));
  gh.lazySingleton<GetArticles>(() => GetArticles(get<ArticlesRepository>()));
  gh.lazySingleton<GetCategories>(
      () => GetCategories(get<CategoriesRepository>()));
  gh.lazySingleton<NewsStore>(
      () => NewsStore(get<GetCategories>(), get<GetArticles>()));
  return get;
}

class _$RegisterModule extends RegisterModule {}
