import 'package:example/page/page_of_discovery.dart';
import 'package:example/page/page_of_home.dart';
import 'package:example/page/page_of_me.dart';
import 'package:example/util/logger.dart';
import 'package:flutter/material.dart';

class PagesManager {
  static late BuildContext appContext;

  static GlobalKey keyTabBar = GlobalKey(debugLabel: '__GLOBAL_KEY_TAB_BARS__');

  static TabController get tabController => DefaultTabController.of(keyTabBar.currentContext!)!;

  static void init() {
    Logger.d('[PagesManager] init');
    tabController.removeListener(_fnRebuildTabBars);
    tabController.addListener(_fnRebuildTabBars);
  }

  static _fnRebuildTabBars() {
    Logger.d('[PagesManager] tab changed index: ${tabController.previousIndex} -> ${tabController.index}');
    (keyTabBar.currentContext as StatefulElement).markNeedsBuild();
  }

  static Widget getAppBody() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Expanded(child: TabBarView(children: _getPages())),
          StatefulBuilder(
            key: keyTabBar,
            builder: (context, setState) {
              return TabBar(
                indicator: const BoxDecoration(),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.grey),
                tabs: _getTabs(),
              );
            },
          ),
        ],
      ),
    );
  }

  static List<Widget> _getTabs() {
    return [
      _createTabIcon(index: 0, name: 'Home'),
      _createTabIcon(index: 1, name: 'Discovery'),
      _createTabIcon(index: 2, name: 'Me'),
    ];
  }

  static List<Widget> _getPages() {
    return [
      PageOfHome(),
      PageOfDiscovery(),
      PageOfMe(),
    ];
  }

  static Color _getColorByTab(String tab) {
    if (tab == 'Home') {
      return Colors.green;
    } else if (tab == 'Discovery') {
      return Colors.redAccent;
    } else if (tab == 'Me') {
      return Colors.amberAccent;
    }
    return Colors.deepOrange;
  }

  static Widget _createTabIcon({required int index, required String name}) {
    bool isSelected = (keyTabBar.currentContext != null ? tabController.index : 0) == index;
    Color color = _getColorByTab(name);
    TextStyle style = TextStyle(color: color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal);
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 16, top: 16),
      child: Column(
        children: [
          Icon(Icons.add, color: color),
          const SizedBox(height: 2.0),
          Text(name, style: style),
        ],
      ),
    );
  }
}
