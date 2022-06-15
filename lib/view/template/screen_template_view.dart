import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../component/button/icon_button_component.dart';

class ScreenTemplateView extends StatelessWidget {
  final String? titleText;
  final Widget? titleIcon;

  final Widget? layout;

  final IconButtonComponent? actionTopLeft;
  final List<IconButtonComponent>? actionTopRightList;
  final Widget? actionBottom;

  final PreferredSize? navigatorTop;
  final Widget? navigatorLeft;
  final Widget? navigatorRight;
  final Widget? navigatorBottom;

  final Color? foregroundColor;
  final Color? backgroundColor;

  final bool enableSheetMode;
  final bool enableHeaderMode;

  const ScreenTemplateView({
    Key? key,
    required this.layout,
    this.titleText,
    this.titleIcon,
    this.actionTopLeft,
    this.actionTopRightList,
    this.actionBottom,
    this.navigatorTop,
    this.navigatorLeft,
    this.navigatorRight,
    this.navigatorBottom,
    this.foregroundColor,
    this.backgroundColor,
  })  : enableSheetMode = false,
        enableHeaderMode = true,
        super(key: key);

  const ScreenTemplateView.sheet({
    Key? key,
    required this.layout,
    this.titleText,
    this.titleIcon,
    this.actionTopLeft,
    this.actionTopRightList,
    this.actionBottom,
    this.navigatorLeft,
    this.navigatorRight,
    this.navigatorBottom,
    this.foregroundColor,
    this.backgroundColor,
  })  : navigatorTop = null,
        enableSheetMode = true,
        enableHeaderMode = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBackNavigatorEnabled = ModalRoute.of(context)?.canPop ?? false;

    return Scaffold(
      appBar: AppBar(
        title: _titleLayout(),
        elevation: enableSheetMode ? 0.0 : null,
        backgroundColor: enableSheetMode ? Colors.transparent : null,
        foregroundColor: foregroundColor ?? (enableSheetMode ? Theme.of(context).colorScheme.onSurface : null),
        leading: _topLeftHeaderAction(context, isBackNavigatorEnabled),
        leadingWidth: isBackNavigatorEnabled ? 70.0 : null,
        actions: actionTopRightList,
        bottom: navigatorTop,
      ),
      extendBodyBehindAppBar: enableSheetMode,
      extendBody: true,
      body: layout,
      drawer: navigatorLeft,
      endDrawer: navigatorRight,
      bottomSheet: actionBottom,
      bottomNavigationBar: navigatorBottom,
      backgroundColor: backgroundColor,
    );
  }

  Widget? _titleLayout() {
    final widgetList = <Widget> [];

    if (titleIcon is Widget) {
      widgetList.add(
        SizedBox.square(
          dimension: 32.0,
          child: titleIcon,
        ),
      );
    }

    if (titleText?.trim().isNotEmpty ?? false) {
      if (widgetList.isNotEmpty) {
        widgetList.add(
          const SizedBox.square(
            dimension: 12.0,
          ),
        );
      }

      widgetList.add(Text(titleText ?? ''));
    }

    if (widgetList.isEmpty) {
      return null;
    } else if (widgetList.length > 1) {
      return Row(
        children: widgetList,
      );
    } else {
      return widgetList.first;
    }
  }

  Widget? _topLeftHeaderAction(final BuildContext context, final bool isBackNavigatorEnabled) {
    final widgetList = <Widget> [];

    if (isBackNavigatorEnabled) {
      Color? color = foregroundColor;

      if (color == null) {
        if (enableSheetMode) {
          color = Theme.of(context).colorScheme.onSurface;
        } else {
          color = Theme.of(context).colorScheme.onPrimary;
        }
      }


      widgetList.add(
        CupertinoNavigationBarBackButton(
          color: color,
          previousPageTitle: 'Back',
        ),
      );
    }

    if (actionTopLeft is Widget) {
      widgetList.add(actionTopLeft ?? const SizedBox());
    }

    if (widgetList.isEmpty) {
      return null;
    } else if (widgetList.length > 1) {
      return Row(
        children: widgetList,
      );
    } else {
      return widgetList.first;
    }
  }
}
