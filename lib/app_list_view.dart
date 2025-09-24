import 'package:flutter/material.dart';

class AppListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Axis scrollDirection;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Widget? separator;
  final bool isSeparated;
  final ScrollController? controller;

  const AppListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.all(8),
    this.physics,
    this.shrinkWrap = false,
    this.separator,
    this.isSeparated = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (isSeparated) {
      return ListView.separated(
        controller: controller,
        scrollDirection: scrollDirection,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemCount: items.length,
        itemBuilder: (context, index) =>
            itemBuilder(context, index, items[index]),
        separatorBuilder: (context, index) =>
            separator ?? const SizedBox(height: 8),
      );
    }

    return ListView.builder(
      controller: controller,
      scrollDirection: scrollDirection,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, index) =>
          itemBuilder(context, index, items[index]),
    );
  }
}
