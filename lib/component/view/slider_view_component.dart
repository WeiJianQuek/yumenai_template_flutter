import 'package:flutter/material.dart';

enum IndicatorMode {
  none,
  paged,
  dotted,
  elongated,
}

class SliderViewComponent extends StatelessWidget {
  final indicatorKey = GlobalKey<_IndicatorSliderViewComponentState>();

  final int itemCount;
  final Widget Function(BuildContext, int) onBuildItem;

  final bool enableOverlapping;

  final IndicatorMode mode;

  SliderViewComponent({
    Key? key,
    required this.itemCount,
    required this.onBuildItem,
    this.enableOverlapping = true,
    this.mode = IndicatorMode.elongated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageComponent =  PageView.builder(
      itemCount: itemCount,
      itemBuilder: onBuildItem,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (indexPosition) {
        indicatorKey.currentState?.updatePosition(indexPosition);
      },
    );

    final indicatorComponent = IndicatorSliderViewComponent(
      key: indicatorKey,
      indexPosition: 0,
      size: itemCount,
      mode: mode,
    );

    if (mode == IndicatorMode.none) {
      return pageComponent;
    } else if (enableOverlapping) {
      return Stack(
        children: [
          pageComponent,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: indicatorComponent,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: pageComponent,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: indicatorComponent,
          ),
        ],
      );
    }
  }
}

class IndicatorSliderViewComponent extends StatefulWidget {
  final int size;
  final int indexPosition;
  final IndicatorMode mode;

  const IndicatorSliderViewComponent({
    Key? key,
    required this.size,
    required this.indexPosition,
    required this.mode,
  }) : super(key: key);

  @override
  State<IndicatorSliderViewComponent> createState() => _IndicatorSliderViewComponentState();
}

class _IndicatorSliderViewComponentState extends State<IndicatorSliderViewComponent> {
  late int indexPosition = widget.indexPosition;

  @override
  Widget build(BuildContext context) {
    switch(widget.mode) {
      case IndicatorMode.none:
        return const SizedBox();
      case IndicatorMode.dotted:
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 2.5,
          children: List.generate(widget.size, (index) {
            return _dottedIndicator(context, index == indexPosition);
          }),
        );
      case IndicatorMode.elongated:
        return Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(widget.size, (index) {
            return _elongatedIndicator (context, index == indexPosition);
          }),
        );
      case IndicatorMode.paged:
        return Text(
          '${indexPosition + 1}/${widget.size}',
          textAlign: TextAlign.end,
        );
    }
  }

  void updatePosition(final int indexPosition) {
    this.indexPosition = indexPosition;
    if (mounted) setState(() {});
  }

  Widget _dottedIndicator(final BuildContext context, final bool isSelected) {
    return Icon(
      Icons.circle,
      size: 12.0,
      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
    );
  }

  Widget _elongatedIndicator(final BuildContext context, final bool isSelected) {
    final Color color;
    final double width;
    if (isSelected) {
      color = Theme.of(context).colorScheme.primary;
      width = 30.0;
    } else {
      color = Colors.grey;
      width = 10.0;
    }

    return AnimatedContainer(
      width: width,
      height: 10.0,
      margin: const EdgeInsets.all(2.0),
      duration: const Duration(
        milliseconds: 150,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(99),
        )
      ),
    );
  }
}

