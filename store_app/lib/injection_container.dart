import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/local_storage/base_local_storage.dart';
import 'package:e_commerce_app/core/network/apis/api_consumer.dart';
import 'package:e_commerce_app/core/network/apis/end_points.dart';
import 'package:e_commerce_app/domain/repos/category_repo.dart';
import 'package:e_commerce_app/domain/repos/products_repo.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/auth_data_source.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/cart_data_source.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/category_data_source.dart';
import 'package:e_commerce_app/infrastructure/data_source/abstraction/products_data_source.dart';
import 'package:e_commerce_app/infrastructure/data_source/implementation/auth_data_source_impl.dart';
import 'package:e_commerce_app/infrastructure/data_source/implementation/auth_repo_impl.dart';
import 'package:e_commerce_app/infrastructure/data_source/implementation/cart_data_source_impl.dart';
import 'package:e_commerce_app/infrastructure/data_source/implementation/category_data_source_impl.dart';
import 'package:e_commerce_app/infrastructure/data_source/implementation/category_repo_impl.dart';
import 'package:e_commerce_app/infrastructure/data_source/implementation/products_data_source_impl.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/auth_repo.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/cart_repo.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/cart_repo_impl.dart';
import 'package:e_commerce_app/infrastructure/data_source/repo/products_repo_impl.dart';
import 'package:e_commerce_app/infrastructure/external/dio/app_interceptor.dart';
import 'package:e_commerce_app/infrastructure/external/dio/dio_consumer.dart';
import 'package:e_commerce_app/infrastructure/external/local_storage_impl/shared_pref_local_storage_impl.dart';
import 'package:e_commerce_app/presentaion/cubit/app_theme_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/auth_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/cart_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/home_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/register_cubit.dart';
import 'package:e_commerce_app/presentaion/cubit/verify_email_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future initDependencies() async {
  await InjectionHelper.injectExternal();
  InjectionHelper.injectDatasources();
  InjectionHelper.injectRepos();
  InjectionHelper.injectQueries();
  InjectionHelper.injectUsecases();
  InjectionHelper.injectBlocs();
}

abstract class InjectionHelper {
  static Future<void> injectExternal() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    getIt.registerFactory<BaseLocalStorage>(
      () => SharedPrefsLocalStorageImpl(preferences: sharedPreferences),
    );
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<AppInterceptors>(
  AppInterceptors(sharedPrefs: getIt<BaseLocalStorage>()),);

    getIt.registerSingleton<ApiConsumer>(
      DioConsumer(
        baseUrl: EndPoints.baseUrl,
        client: getIt<Dio>(),
        interceptors: [getIt<AppInterceptors>()],
      ),
    );
  }

  // static void injectCore() {}

  static void injectDatasources() {
     getIt.registerLazySingleton<ProductsDataSource>(
      () => ProductsDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
    getIt.registerLazySingleton<CartDataSource>(
      () => CartDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
    getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
    getIt.registerLazySingleton<CategoriesDataSource>(
      () => CategoriesDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
    );
  }

  static void injectRepos() {
    getIt.registerFactory<AuthRepo>(
      () => AuthRepoImpl(authDataSource: getIt<AuthDataSource>()),
    );
    getIt.registerFactory<ProductsRepo>(
      () => ProductsRepoImpl(productsDataSource: getIt<ProductsDataSource>()),
    );
    getIt.registerFactory<CategoriesRepo>(
      () => CategoriesRepoImpl(
        categoriesDataSource: getIt<CategoriesDataSource>(),
      ),
    );
    getIt.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(cartDataSource: getIt<CartDataSource>()),
    );
  }

  // static void injectCommands() {
  //   getIt.registerFactory<LoginContract>(() => LoginContractImpl(authRepo: getIt()));
  // }

  static void injectQueries() {}

  static void injectUsecases() {}

  static void injectBlocs() {
    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(
        getIt<AuthRepo>(),
      ),
    );
    getIt.registerFactory<CartCubit>(
      () => CartCubit(cartRepo: getIt<CartRepo>()),
    );
    getIt.registerFactory<VerifyEmailCubit>(
      () => VerifyEmailCubit(
        getIt<AuthRepo>(),
      ),
    );
    getIt.registerFactory<AppThemeCubit>(
      () => AppThemeCubit(
        localStorage: getIt<BaseLocalStorage>(),
      ),
    );
 getIt.registerFactory<AuthCubit>(
      () => AuthCubit(
        authRepo: getIt<AuthRepo>(),localStorage: getIt<BaseLocalStorage>(),
      ),
    );
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(
        productsRepo: getIt<ProductsRepo>(),
      ),
    );
  }
}