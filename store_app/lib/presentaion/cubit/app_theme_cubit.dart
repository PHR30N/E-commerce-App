import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/constant/local_key.dart';
import 'package:e_commerce_app/core/local_storage/base_local_storage.dart';
import 'package:e_commerce_app/presentaion/cubit/app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  final BaseLocalStorage _localStorage;

  AppThemeCubit({required BaseLocalStorage localStorage})
      : _localStorage = localStorage,
        super(AppThemeState(isDark: true)) {
    _loadTheme();
  }
  Future<void> _loadTheme() async {
    final isDark = await _localStorage.getBool(LocalKey.isDark) ?? false;
    emit(AppThemeState(isDark: isDark));
  }
  Future<void> toggleTheme() async {
    final nextState = !state.isDark;
    await _localStorage.setBool(LocalKey.isDark, nextState);
    emit(AppThemeState(isDark: nextState));
  }
  void resetTheme() {
    emit( AppThemeState(isDark: false));
  }
}