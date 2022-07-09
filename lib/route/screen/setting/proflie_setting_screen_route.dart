import 'package:flutter/material.dart';

import '../../../component/button/icon_button_component.dart';
import '../../../component/text/info_text_component.dart';
import '../../../component/view/list_view_component.dart';
import '../../../view/template/screen_template_view.dart';
import '../../controller/setting/proflie_setting_controller_route.dart';

class ProfileSettingScreenRoute extends StatelessWidget {
  final ProfileSettingControllerRoute controller;

  const ProfileSettingScreenRoute({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      titleText: 'Profile',
      actionTopRightList: [
        IconButtonComponent(
          icon: const Icon(Icons.edit),
          hint: 'Edit',
          onClicked: () {
            controller.edit(context);
          },
        ),
      ],
      layout: ListViewComponent(
        viewList: const [
          InfoTextComponent(
            title: 'Name',
            content: null,
          ),
          InfoTextComponent(
            title: 'Description',
            content: null,
          ),
          InfoTextComponent(
            title: 'Email',
            content: null,
          ),
          InfoTextComponent(
            title: 'Mobile Number',
            content: null,
          ),
          InfoTextComponent(
            title: 'Address',
            content: null,
          ),
        ],
      ),
    );
  }
}
