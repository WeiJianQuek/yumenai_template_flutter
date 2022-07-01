import 'package:flutter/material.dart';

import '../../../component/view/list_view_component.dart';
import '../../../view/item/option_item_view.dart';
import '../../../view/template/screen_template_view.dart';
import '../../controller/setting/language_setting_controller_route.dart';

class LanguageSettingScreenRoute extends StatelessWidget {
  final LanguageSettingControllerRoute controller;

  const LanguageSettingScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      titleText: 'Language',
      layout: ListViewComponent.pagination(
        key: controller.paginationListKey,
        onLoad: (indexPage) {
          return controller.loadLanguageList(context, indexPage);
        },
        onItemCount: () {
          return controller.languageLocaleModelList.length;
        },
        onItemBuild: (context, indexPosition) {
          return OptionItemView.single(
            title: controller.languageLocaleModelList[indexPosition].name,
            onListen: () => controller.selectedIndexPosition == indexPosition,
            onSelect: () => controller.updateSelectedItem(indexPosition),
          );
        },
      ),
    );
  }
}
