import 'package:flutter/material.dart';

import '../data/resource/color_resource_data.dart';
import '../data/resource/image_resource_data.dart';

class ResourceController with ChangeNotifier {
  static ResourceController setup() {
    return ResourceController._();
  }

  Brightness _brightness = Brightness.light;
  ColorResourceData _color = const ColorResourceData.light();
  ImageResourceData _image = const ImageResourceData.light();
  ThemeMode _themeMode = ThemeMode.system;

  ResourceController._();

  Brightness get brightness => _brightness;

  ColorResourceData get color => _color;

  ImageResourceData get image => _image;

  ThemeMode get themeMode => _themeMode;

  void updateBrightness(final Brightness brightness) {
    if (brightness == Brightness.dark) {
      _updateDarkMode();
    } else {
      _updateLightMode();
    }
  }

  void updateTheme(final ThemeMode themeMode) {
    if (_themeMode != themeMode) {
      if (themeMode == ThemeMode.system) {
        updateBrightness(WidgetsBinding.instance.window.platformBrightness);
      } else {
        if (themeMode == ThemeMode.dark) {
          _updateDarkMode();
        } else {
          _updateLightMode();
        }
      }

      _themeMode = themeMode;

      notifyListeners();
    }
  }

  void _updateDarkMode() {
    _brightness = Brightness.dark;
    _color = const ColorResourceData.dark();
    _image = const ImageResourceData.dark();
  }

  void _updateLightMode() {
    _brightness = Brightness.light;
    _color = const ColorResourceData.light();
    _image = const ImageResourceData.light();
  }
}
