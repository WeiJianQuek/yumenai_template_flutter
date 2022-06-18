import 'package:flutter/material.dart';

import '../../component/view/list_view_component.dart';

// The purpose of this component is to standardise all multiple option view interface design

enum MultipleOptionMode {
  checkboxes,
  switches,
}

class MultipleOptionView extends StatefulWidget {
  static Widget builder({
    required final int itemCount,
    required final bool Function(int) onListen,
    required final String Function(int) onBuild,
    required final void Function(int) onSelect,
    final MultipleOptionMode mode = MultipleOptionMode.checkboxes,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return ListViewComponent.builder(
          itemCount: itemCount,
          onItemBuild: (context, indexPosition) {
            return _optionItem(
              title: onBuild(indexPosition),
              isSelected: onListen(indexPosition),
              mode: mode,
              onClicked: () {
                onSelect(indexPosition);
                setState(() {});
              },
            );
          },
        );
      },
    );
  }

  static Widget _optionItem({
    required final String title,
    required final bool isSelected,
    required final MultipleOptionMode mode,
    required void Function() onClicked,
  }) {

    switch(mode) {
      case MultipleOptionMode.switches:
        return SwitchListTile(
          title: Text(title),
          value: isSelected,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          onChanged: (_) {
            onClicked();
          },
        );
      case MultipleOptionMode.checkboxes:
        return CheckboxListTile(
          title: Text(title),
          value: isSelected,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          onChanged: (_) {
            onClicked();
          },
        );
    }
  }

  final MultipleOptionMode mode;
  final List<String> titleOptionList;
  final bool enableScrollable;
  // Listen to selected index position of option
  final bool Function(int) onListen;
  // Return the selected index position of selected option
  final void Function(int) onSelect;

  const MultipleOptionView({
    Key? key,
    required this.titleOptionList,
    required this.onListen,
    required this.onSelect,
    this.enableScrollable = false,
    this.mode = MultipleOptionMode.checkboxes,
  }) :  super(key: key);

  @override
  State<MultipleOptionView> createState() => _MultipleOptionViewState();
}

class _MultipleOptionViewState extends State<MultipleOptionView> {
  @override
  Widget build(BuildContext context) {
    final itemList = <Widget> [];
    for (int i = 0; i < widget.titleOptionList.length; i++) {
      itemList.add(
        MultipleOptionView._optionItem(
          title: widget.titleOptionList[i],
          isSelected: widget.onListen(i),
          mode: widget.mode,
          onClicked: () {
            widget.onSelect(i);
            if (mounted) setState(() {});
          },
        ),
      );
    }

    if (widget.enableScrollable) {
      return ListViewComponent(
        viewList: itemList,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: itemList,
      );
    }
  }
}
