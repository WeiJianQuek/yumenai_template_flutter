import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/app_controller.dart';
import '../../data/resource/color_resource_data.dart';
import '../../main.dart';
import '../../route/controller/entry/splash_entry_controller_route.dart';

const _lightColorResource = ColorResourceData.light();
const _darkColorResource = ColorResourceData.dark();

class AppTemplateView extends StatefulWidget {
  final AppController appController;

  const AppTemplateView({
    Key? key,
    required this.appController,
  }) : super(key: key);

  @override
  State<AppTemplateView> createState() => _AppTemplateViewState();
}

class _AppTemplateViewState extends State<AppTemplateView> with WidgetsBindingObserver {
  final lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light(
      primary: _lightColorResource.primary,
      onPrimary: _lightColorResource.onPrimary,
      primaryContainer: _lightColorResource.primaryContainer,
      onPrimaryContainer: _lightColorResource.onPrimaryContainer,
      secondary: _lightColorResource.secondary,
      onSecondary: _lightColorResource.onSecondary,
      secondaryContainer: _lightColorResource.secondaryContainer,
      onSecondaryContainer: _lightColorResource.onSecondaryContainer,
      error: _lightColorResource.error,
      onError: _lightColorResource.onError,
      errorContainer: _lightColorResource.errorContainer,
      onErrorContainer: _lightColorResource.onErrorContainer,
      surface: _lightColorResource.surface,
      onSurface: _lightColorResource.onSurface,
      background: _lightColorResource.background,
      onBackground: _lightColorResource.onBackground,
    ),
    brightness: Brightness.light,
  );

  final darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark(
      primary: _darkColorResource.primary,
      onPrimary: _darkColorResource.onPrimary,
      primaryContainer: _darkColorResource.primaryContainer,
      onPrimaryContainer: _darkColorResource.onPrimaryContainer,
      secondary: _darkColorResource.secondary,
      onSecondary: _darkColorResource.onSecondary,
      secondaryContainer: _darkColorResource.secondaryContainer,
      onSecondaryContainer: _darkColorResource.onSecondaryContainer,
      error: _darkColorResource.error,
      onError: _darkColorResource.onError,
      errorContainer: _darkColorResource.errorContainer,
      onErrorContainer: _darkColorResource.onErrorContainer,
      surface: _darkColorResource.surface,
      onSurface: _darkColorResource.onSurface,
      background: _darkColorResource.background,
      onBackground: _darkColorResource.onBackground,
    ),
    brightness: Brightness.dark,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      app.updateBrightness(WidgetsBinding.instance.window.platformBrightness);
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.appController,
      builder: (context, _) {
        final SystemUiOverlayStyle systemUiOverlayStyle;

        if (widget.appController.themeMode == ThemeMode.system) {
          if (WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
            systemUiOverlayStyle = SystemUiOverlayStyle.dark;
          } else {
            systemUiOverlayStyle = SystemUiOverlayStyle.light;
          }
        } else {
          if (widget.appController.resource.brightness == Brightness.dark) {
            systemUiOverlayStyle = SystemUiOverlayStyle.dark;
          } else {
            systemUiOverlayStyle = SystemUiOverlayStyle.light;
          }
        }

       return  AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle.copyWith(
            systemNavigationBarColor: widget.appController.resource.color.system,
            systemNavigationBarDividerColor: widget.appController.resource.color.system,
            statusBarColor: widget.appController.resource.color.system,
          ),
          child: MaterialApp(
            title: 'Flutter Template',
            theme: lightTheme,
            darkTheme: darkTheme,
            home: SplashEntryControllerRoute.screen(),
            themeMode: widget.appController.themeMode,
          ),
        );
      }
    );
  }
}
