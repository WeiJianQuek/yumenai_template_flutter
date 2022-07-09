import 'package:flutter/material.dart';

import '../../../component/view/list_view_component.dart';
import '../../../view/item/option_item_view.dart';
import '../../../view/template/screen_template_view.dart';
import '../../controller/setting/theme_setting_controller_route.dart';

class ThemeSettingScreenRoute extends StatelessWidget {
  final ThemeSettingControllerRoute controller;

  const ThemeSettingScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      titleText: 'Theme',
      layout: ListViewComponent.pagination(
        key: controller.paginationListKey,
        onLoad: (indexPage) {
          return controller.loadThemeList(context, indexPage);
        },
        onItemCount: () {
          return controller.themeVariableDataMap.length;
        },
        onItemBuild: (context, indexPosition) {
          return OptionItemView.single(
            title: controller.themeVariableDataMap.values.elementAt(indexPosition),
            onListen: () => controller.selectedIndexPosition == indexPosition,
            onSelect: () => controller.updateSelectedItem(indexPosition),
          );
        },
      ),
    );
  }
}
