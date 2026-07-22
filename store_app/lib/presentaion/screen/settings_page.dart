import 'package:e_commerce_app/presentaion/cubit/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/app_theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: BlocBuilder<AppThemeCubit, AppThemeState>(
        builder: (context, state) {
          final isDark = (state is AppThemeState) && state.isDark;
          return SwitchListTile(
            title: const Text("Dark Mode"),
            secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            value: isDark,
            onChanged: (_) {
              context.read<AppThemeCubit>().toggleTheme();
            },
          );
        },
      ),
    );
  }
}
