import 'package:flutter/material.dart';

import '../../../utility/navigator_utility.dart';
import '../../screen/setting/proflie_setting_screen_route.dart';

class ProfileSettingControllerRoute {
  static void navigate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: const ProfileSettingScreenRoute(
        controller: ProfileSettingControllerRoute._(),
      ),
    );
  }

  const ProfileSettingControllerRoute._();

  void edit(final BuildContext context) {

  }
}