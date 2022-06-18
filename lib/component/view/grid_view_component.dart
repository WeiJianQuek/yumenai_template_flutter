import 'package:flutter/material.dart';

/// This component was created using ListView
/// is because GridView requires Aspect Ratio to be defined.

class GridViewComponent extends ListView {
  static GlobalKey<PaginationGridViewComponentState> setupPaginationKey() {
    return GlobalKey<PaginationGridViewComponentState>();
  }

  static Widget pagination({
    GlobalKey<PaginationGridViewComponentState>? key,
    required final int rowCount,
    required final Future<bool> Function(int indexPage) onLoad,
    required final int Function() onItemCount,
    required final Widget Function(BuildContext context, int indexPosition) onItemBuild,
    final int initialIndexPage = 1,
    final ScrollController? controller,
    final EdgeInsets? padding,
  }) {
    return PaginationGridViewComponent(
      key: key,
      rowCount: rowCount,
      onLoad: onLoad,
      onItemCount: onItemCount,
      onItemBuild: onItemBuild,
      initialIndexPage: initialIndexPage,
      controller: controller,
      padding: padding,
    );
  }

  static Widget _rowItem({
    required final int rowCount,
    required final int itemCount,
    required final int listPosition,
    required final Widget Function(int itemPosition) onBuild,
  }) {
    return Row(
      children: List.generate(rowCount, (rowPosition) {
        final itemPosition = (listPosition * rowCount) + rowPosition;
        if (itemPosition < itemCount) {
          return Expanded(
            child: onBuild(itemPosition),
          );
        } else {
          return const Expanded(
            child: SizedBox(),
          );
        }
      },),
    );
  }

  GridViewComponent({
    Key? key,
    required final int rowCount,
    required final List<Widget> itemList,
    final bool enableReverse = false,
    final bool enableShrinkage = false,
  }) : super(
    key: key,
    children: [
      for (int listPosition = 0; listPosition < (itemList.length / rowCount).ceil(); listPosition++)
        _rowItem(
          rowCount: rowCount,
          itemCount: itemList.length,
          listPosition: listPosition,
          onBuild: (itemPosition) {
            return itemList[itemPosition];
          },
        ),
    ],
    reverse: enableReverse,
    shrinkWrap: enableShrinkage,
  );

  GridViewComponent.builder({
    Key? key,
    required final int rowCount,
    required final int itemCount,
    required final Widget Function(BuildContext context, int indexPosition) onItemBuild,
    final Widget? bottom,
    final EdgeInsets? padding,
    final ScrollController? controller,
    final double? itemSpacing,
    final double? rowSpacing,
  }) : super.builder(
    key: key,
    itemCount: (itemCount/rowCount).ceil() + 1,
    itemBuilder: (context, listPosition) {
      if (listPosition + 1 < itemCount) {
        return _rowItem(
          rowCount: rowCount,
          itemCount: itemCount,
          listPosition: listPosition,
          onBuild: (itemPosition) {
            return onItemBuild(context, itemPosition);
          },
        );
      } else {
        return bottom ?? const SizedBox();
      }
    },
    padding: padding,
    controller: controller,
  );
}

class PaginationGridViewComponent extends StatefulWidget {
  final int rowCount;
  final Future<bool> Function(int indexPage) onLoad;
  final int Function() onItemCount;
  final Widget Function(BuildContext context, int indexPosition) onItemBuild;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final int initialIndexPage;

  const PaginationGridViewComponent({
    Key? key,
    required this.rowCount,
    required this.onLoad,
    required this.onItemCount,
    required this.onItemBuild,
    required this.initialIndexPage,
    required this.controller,
    required this.padding,
  }) : super(key: key);

  @override
  PaginationGridViewComponentState createState() => PaginationGridViewComponentState();
}

class PaginationGridViewComponentState extends State<PaginationGridViewComponent> {
  late final ScrollController _controller;

  bool _isLoading = false;
  bool _isLoadable = true;
  int _indexPage = 0;

  @override
  void initState() {
    _indexPage = widget.initialIndexPage;
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0) {
          _triggerOnLoad();
        }
      }
    });
    _triggerOnLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridViewComponent.builder(
      padding: widget.padding,
      controller: _controller,
      rowCount: widget.rowCount,
      itemCount: widget.onItemCount(),
      onItemBuild: (context, indexPosition) {
        return widget.onItemBuild(context, indexPosition);
      },
      bottom: _isLoadable ? const Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : const SizedBox(
        height: 100.0,
      ),
    );
  }

  void reset() {
    _isLoadable = true;
    _isLoading = false;
    _indexPage = widget.initialIndexPage;
    _triggerOnLoad();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void _triggerOnLoad() async {
    if (!_isLoading) {
      if (_isLoadable) {
        _isLoading = true;
        _isLoadable = await widget.onLoad.call(_indexPage++);
        _isLoading = false;
        if (mounted) setState(() {});
      }
    }
  }
}
