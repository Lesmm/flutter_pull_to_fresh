import 'dart:math' as math;

import 'package:example/util/logger.dart';
import 'package:flutter/cupertino.dart';

typedef SliverHeaderBuilder = Widget? Function(BuildContext context, double offset, bool isOverlaps);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    this.name,
    this.child,
    this.builder,
  });

  final double minHeight;
  final double maxHeight;
  final String? name;
  final Widget? child;
  final SliverHeaderBuilder? builder;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Logger.d('[XpHomeSliverDelegate] $name >>> build: $shrinkOffset, $overlapsContent');
    return builder?.call(context, shrinkOffset, overlapsContent) ?? child ?? const Offstage(offstage: true);
  }

  @override
  bool shouldRebuild(SliverHeaderDelegate oldDelegate) {
    bool isRebuild = maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
    // Logger.d('[XpHomeSliverDelegate] $name >>> shouldRebuild: $isRebuild');
    return isRebuild;
  }
}

class SliverHeader extends SliverPersistentHeader {
  SliverHeader({
    Key? key,
    bool? pinned,
    bool? floating,
    double? minHeight,
    double? maxHeight,
    String? name,
    Widget? child,
    SliverHeaderBuilder? builder,
  }) : super(
          key: key,
          pinned: pinned ?? false,
          floating: floating ?? false,
          delegate: SliverHeaderDelegate(
            minHeight: minHeight ?? 38,
            maxHeight: maxHeight ?? 100,
            name: name,
            child: child,
            builder: builder,
          ),
        );
}
