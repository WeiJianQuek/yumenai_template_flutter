import 'package:flutter/material.dart';

const _scrollPhysic = BouncingScrollPhysics();

class ListViewComponent extends ListView {
  static GlobalKey<PaginationListViewComponentState> setupPaginationKey() {
    return GlobalKey<PaginationListViewComponentState>();
  }

  static Widget pagination({
    GlobalKey<PaginationListViewComponentState>? key,
    required final int Function() onCount,
    required final Widget Function(int) onBuild,
    required final Future<bool> Function(int)? onLoad,
    final ScrollController? controller,
    final Widget? header,
    final bool enableReverse = false,
    final Axis axis = Axis.vertical,
    final EdgeInsets? padding,
    final int initialIndexPage = 1,
  }) {
    return PaginationListViewComponent(
      key: key,
      onCount: onCount,
      onBuild: onBuild,
      onLoad: onLoad,
      controller: controller,
      header: header,
      enableReverse: enableReverse,
      axis: axis,
      padding: padding,
      initialIndexPage: initialIndexPage,
    );
  }

  ListViewComponent({
    Key? key,
    required final List<Widget> viewList,
    final ScrollController? controller,
    final bool enableShrinkage = false,
    final bool enableReverse = false,
    final Axis axis = Axis.vertical,
    final EdgeInsets? padding,
  }) : super(
    key: key,
    padding: padding,
    physics: _scrollPhysic,
    children: viewList,
    controller: controller,
    shrinkWrap: enableShrinkage,
    scrollDirection: axis,
    reverse: enableReverse,
  );

  ListViewComponent.builder({
    Key? key,
    required final int count,
    required Widget Function(int) onBuild,
    final ScrollController? controller,
    final bool enableShrinkage = false,
    final bool enableReverse = false,
    final Axis axis = Axis.vertical,
    final EdgeInsets? padding,
  }) : super.builder(
    key: key,
    padding: padding,
    physics: _scrollPhysic,
    controller: controller,
    shrinkWrap: enableReverse,
    scrollDirection: axis,
    itemCount: count,
    itemBuilder: (context, index) {
      return onBuild(index);
    },
  );
}

class PaginationListViewComponent extends StatefulWidget {
  final int Function() onCount;
  final Widget Function(int) onBuild;
  final Future<bool> Function(int)? onLoad;
  final ScrollController? controller;
  final Widget? header;
  final bool enableReverse;
  final Axis axis;
  final EdgeInsets? padding;
  final int initialIndexPage;

  const PaginationListViewComponent({
    Key? key,
    required this.onCount,
    required this.onBuild,
    required this.onLoad,
    required this.initialIndexPage,
    required this.header,
    required this.controller,
    required this.enableReverse,
    required this.axis,
    required this.padding,
  }) : super(key: key);

  @override
  PaginationListViewComponentState createState() => PaginationListViewComponentState();
}

class PaginationListViewComponentState extends State<PaginationListViewComponent> {
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
    final viewCount = widget.onCount();

    return ListViewComponent.builder(
      padding: widget.padding,
      controller: _controller,
      enableReverse: widget.enableReverse,
      axis: widget.axis,
      count: viewCount + 2,
      onBuild: (indexPosition) {
        if (indexPosition == 0) {
          return widget.header ?? const SizedBox();
        } else if (indexPosition <= viewCount) {
          return widget.onBuild(indexPosition - 1);
        } else {
          if (_isLoadable) {
            return const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const SizedBox(
              height: 100.0,
            );
          }
        }
      },
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

  void _triggerOnLoad() {
    if (!_isLoading) {
      if (_isLoadable) {
        _isLoading = true;
        widget.onLoad?.call(_indexPage++).then((value) {
          _isLoading = false;
          _isLoadable = value;
          if (mounted) setState(() {});
        });
      }
    }
  }
}
