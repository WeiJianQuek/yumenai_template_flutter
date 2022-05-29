import 'package:flutter/material.dart';

const _scrollPhysic = BouncingScrollPhysics();

class ListViewComponent extends ListView {
  static GlobalKey<PaginationListViewComponentState> setupPaginationKey() {
    return GlobalKey<PaginationListViewComponentState>();
  }

  static Widget pagination({
    GlobalKey<PaginationListViewComponentState>? key,
    required final Future<bool> Function(int indexPage) onLoad,
    required final int Function() onItemCount,
    required final Widget Function(BuildContext context, int indexPosition) onItemBuild,
    final ScrollController? controller,
    final Axis axis = Axis.vertical,
    final EdgeInsets? padding,
    final int initialIndexPage = 1,
  }) {
    return PaginationListViewComponent(
      key: key,
      onItemCount: onItemCount,
      onItemBuild: onItemBuild,
      onLoad: onLoad,
      controller: controller,
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
    required final int itemCount,
    required Widget Function(BuildContext context, int indexPosition) onItemBuild,
    final ScrollController? controller,
    final Axis axis = Axis.vertical,
    final EdgeInsets? padding,
  }) : super.builder(
    key: key,
    padding: padding,
    physics: _scrollPhysic,
    controller: controller,
    scrollDirection: axis,
    itemCount: itemCount,
    itemBuilder: onItemBuild,
  );
}

class PaginationListViewComponent extends StatefulWidget {
  final Future<bool> Function(int indexPage) onLoad;
  final int Function() onItemCount;
  final Widget Function(BuildContext context, int indexPosition) onItemBuild;
  final ScrollController? controller;
  final Axis axis;
  final EdgeInsets? padding;
  final int initialIndexPage;

  const PaginationListViewComponent({
    Key? key,
    required this.onLoad,
    required this.onItemCount,
    required this.onItemBuild,
    required this.initialIndexPage,
    required this.controller,
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
    final viewCount = widget.onItemCount();

    return ListViewComponent.builder(
      padding: widget.padding,
      controller: _controller,
      axis: widget.axis,
      itemCount: viewCount + 1,
      onItemBuild: (context, indexPosition) {
        if (indexPosition < viewCount) {
          return widget.onItemBuild(context, indexPosition);
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
