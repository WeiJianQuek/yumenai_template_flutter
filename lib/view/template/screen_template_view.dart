import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../component/button/icon_button_component.dart';
import '../../component/view/image_view_component.dart';
import '../../component/view/list_view_component.dart';
import '../../main.dart';

const _rootTag = 'screen_template_view';

const _avatarTag = 'avatar_$_rootTag';
const _titleTag = 'title_$_rootTag';
const _subtitleTag = 'subtitle_$_rootTag';
const _actionPrimaryTag = 'action_primary_$_rootTag';
const _actionSecondaryTag = 'action_secondary_$_rootTag';
const _creditTag = 'credit_$_rootTag';

class ScreenTemplateView extends StatelessWidget {
  static Widget avatar({
    final String? title,
    final String? subtitle,
    final Widget? form,
    final Widget? actionPrimary,
    final Widget? actionSecondary,
  }) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ListViewComponent(
                padding: const EdgeInsets.only(
                  top: 100.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                enableReverse: true,
                enableShrinkage: true,
                viewList: [
                  if (actionSecondary is Widget)
                    ...[
                      Hero(
                        tag: _actionSecondaryTag,
                        child: Material(
                          type: MaterialType.transparency,
                          child: actionSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                    ],
                  if (actionPrimary is Widget)
                    Hero(
                      tag: _actionPrimaryTag,
                      child: Material(
                        type: MaterialType.transparency,
                        child: actionPrimary,
                      ),
                    ),
                  const SizedBox.square(
                    dimension: 32.0,
                  ),
                  if (form is Widget) form,
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (subtitle?.isNotEmpty ?? false)
                    Hero(
                      tag: _subtitleTag,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          subtitle ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  if (title?.isNotEmpty ?? false)
                    Hero(
                      tag: _titleTag,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          title ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Center(
                    child: SizedBox.square(
                      dimension: 200.0,
                      child: Hero(
                        tag: _avatarTag,
                        child: ImageViewComponent.asset(
                          path: resource.image.appSplash,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Hero(
            tag: _creditTag,
            child: Material(
              type: MaterialType.transparency,
              child: Text(
                'Powered By Yumenai',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF616161),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }

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
