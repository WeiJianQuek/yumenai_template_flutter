import 'package:flutter/material.dart';

import '../../../component/view/list_view_component.dart';
import '../../../data/variable/theme_variable_data.dart';
import '../../../main.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/setting/theme_setting_screen_route.dart';

class ThemeSettingControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: ThemeSettingScreenRoute(
        controller: ThemeSettingControllerRoute._(),
      ),
    );
  }

  final paginationListKey = ListViewComponent.setupPaginationKey();
  final themeVariableDataMap = <ThemeVariableData, String> {};

  int? selectedIndexPosition = 0;

  ThemeSettingControllerRoute._();

  Future<bool> loadThemeList(final BuildContext context, final indexPage) async {
    themeVariableDataMap[ThemeVariableData.system] = 'System';
    themeVariableDataMap[ThemeVariableData.light] = 'Light';
    themeVariableDataMap[ThemeVariableData.dark] = 'Dark';

    for (int i = 0; i < themeVariableDataMap.keys.length; i++) {
      final data = themeVariableDataMap.keys.elementAt(i);
      if (data.themeMode == resource.themeMode) {
        selectedIndexPosition = i;
      }
    }

    return false;
  }

  void updateSelectedItem(final int indexPosition) {
    if (selectedIndexPosition != indexPosition) {
      selectedIndexPosition = indexPosition;
      paginationListKey.currentState?.refresh();
      resource.updateTheme(themeVariableDataMap.keys.toList()[indexPosition].themeMode);
    }
  }
}
