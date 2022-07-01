import 'package:flutter/material.dart';

import '../../component/button/icon_button_component.dart';
import '../../component/view/list_view_component.dart';
import '../../view/template/screen_template_view.dart';
import '../controller/dashboard_controller_route.dart';

class DashboardScreenRoute extends StatelessWidget {
  final DashboardControllerRoute controller;

  const DashboardScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      titleText: 'Flutter Template',
      actionTopRightList: [
        IconButtonComponent(
          icon: const Icon(Icons.settings),
          hint: 'Settings',
          onClicked: () {
            controller.navigateSettings(context);
          },
        ),
      ],
      layout: ListViewComponent(
        viewList: const [

        ],
      ),
    );
  }
}
