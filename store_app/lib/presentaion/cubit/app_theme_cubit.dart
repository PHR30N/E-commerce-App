import 'package:e_commerce_app/presentaion/cubit/app_theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<AppThemeState>{
  AppThemeCubit(): super(AppThemeState(isDark:false));
  void toggleTheme(){
    emit(AppThemeState(isDark: !state.isDark));
  }
}