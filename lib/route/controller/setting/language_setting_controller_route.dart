import 'package:flutter/material.dart';

import '../../../component/view/list_view_component.dart';
import '../../../model/locale/language_locale_model.dart';
import '../../../utility/navigator_utility.dart';
import '../../screen/setting/language_setting_screen_route.dart';

class LanguageSettingControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: LanguageSettingScreenRoute(
        controller: LanguageSettingControllerRoute._(),
      ),
    );
  }

  final paginationListKey = ListViewComponent.setupPaginationKey();
  final languageLocaleModelList = <LanguageLocaleModel> [];
  int? selectedIndexPosition;

  LanguageSettingControllerRoute._();

  Future<bool> loadLanguageList(final BuildContext context, final indexPage) async {
    // TODO get data
    return false;
  }

  void updateSelectedItem(final int indexPosition) {
    if (selectedIndexPosition != indexPosition) {
      selectedIndexPosition = indexPosition;
      paginationListKey.currentState?.refresh();
    }
  }
}
