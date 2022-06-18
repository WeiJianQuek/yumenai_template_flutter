import 'package:flutter/material.dart';

import '../../component/view/list_view_component.dart';

// The purpose of this component is to standardise all single option view interface design

class SingleOptionView extends StatefulWidget {
  static Widget builder({
    required final int itemCount,
    required final int? Function() onListen,
    required final String Function(int) onBuild,
    required final void Function(int) onSelect,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return ListViewComponent.builder(
          itemCount: itemCount,
          onItemBuild: (context, indexPosition) {
            return _optionItem(
              title: onBuild(indexPosition),
              isSelected: onListen() == indexPosition,
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
    required void Function() onClicked,
  }) {
    return RadioListTile(
      title: Text(title),
      value: isSelected,
      groupValue: true,
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

  final List<String> titleOptionList;
  final bool enableScrollable;
  // Listen to selected index position of option
  final int? Function() onListen;
  // Return the selected index position of selected option
  final void Function(int) onSelect;

  const SingleOptionView({
    Key? key,
    required this.titleOptionList,
    required this.onListen,
    required this.onSelect,
    this.enableScrollable = false,
  }) :  super(key: key);

  @override
  State<SingleOptionView> createState() => _SingleOptionViewState();
}

class _SingleOptionViewState extends State<SingleOptionView> {
  @override
  Widget build(BuildContext context) {
    final itemList = <Widget> [];
    for (int i = 0; i < widget.titleOptionList.length; i++) {
      itemList.add(
        SingleOptionView._optionItem(
          title: widget.titleOptionList[i],
          isSelected: widget.onListen() == i,
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
