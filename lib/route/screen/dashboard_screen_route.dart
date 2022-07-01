import 'package:flutter/material.dart';

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
      layout: ListViewComponent(
        viewList: const [],
      ),
    );
  }
}
