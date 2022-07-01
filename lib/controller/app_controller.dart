import 'package:flutter/material.dart';

import '../data/resource/color_resource_data.dart';
import '../data/resource/image_resource_data.dart';
import '../route/controller/entry/splash_entry_controller_route.dart';
import '../service/storage_service.dart';

class AppController with ChangeNotifier {
  static Future<AppController> setup() async {
    return AppController._(
      service: await ServiceApp.setup(),
    );
  }

  final ServiceApp service;
  ThemeMode themeMode = ThemeMode.system;
  ResourceApp resource = ResourceApp.light();

  AppController._({
    required this.service,
  });

  void updateBrightness(final Brightness brightness) {
    if (brightness == Brightness.dark) {
      resource = ResourceApp.dark();
    } else {
      resource = ResourceApp.light();
    }
  }

  void updateTheme(final ThemeMode themeMode) {
    if (this.themeMode != themeMode) {
      if (themeMode == ThemeMode.system) {
        updateBrightness(WidgetsBinding.instance.window.platformBrightness);
      } else {
        if (themeMode == ThemeMode.dark) {
          resource = ResourceApp.dark();
        } else {
          resource = ResourceApp.light();
        }
      }

      this.themeMode = themeMode;

      notifyListeners();
    }
  }

  void signOut(final BuildContext context) async {
    await service.storage.keyValue.clear();
    SplashEntryControllerRoute.navigate(context);
  }
}

class ResourceApp {
  final Brightness brightness;
  final ColorResourceData color;
  final ImageResourceData image;

  ResourceApp.light()
      : brightness = Brightness.light,
        color = const ColorResourceData.light(),
        image = const ImageResourceData.light();

  ResourceApp.dark()
      : brightness = Brightness.dark,
        color = const ColorResourceData.dark(),
        image = const ImageResourceData.dark();
}

class ServiceApp {
  static Future<ServiceApp> setup() async {
    return ServiceApp._(
      storage: await StorageService.setup(),
    );
  }

  final StorageService storage;

  const ServiceApp._({
    required this.storage,
  });
}
