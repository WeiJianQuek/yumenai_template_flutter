import 'package:flutter/material.dart';

enum ThemeVariableData {
  system,
  light,
  dark,
}

extension ThemeVariableDataExtension on ThemeVariableData {
  bool get isSystem => this == ThemeVariableData.system;

  bool get isLight => this == ThemeVariableData.light;

  bool get isDark => this == ThemeVariableData.dark;

  ThemeMode get themeMode {
    switch(this) {
      case ThemeVariableData.system:
        return ThemeMode.system;
      case ThemeVariableData.light:
        return ThemeMode.light;
      case ThemeVariableData.dark:
        return ThemeMode.dark;
    }
  }
}
