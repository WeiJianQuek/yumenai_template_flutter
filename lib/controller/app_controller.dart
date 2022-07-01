import 'package:flutter/material.dart';

import '../data/resource/color_resource_data.dart';
import '../data/resource/image_resource_data.dart';

class AppController with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  ResourceApp resource = ResourceApp.light();

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