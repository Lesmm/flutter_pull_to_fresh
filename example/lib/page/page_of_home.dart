import 'package:example/view/sliver_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pull_to_fresh/pull_to_refresh.dart';

class PageOfHome extends StatelessWidget {
  PageOfHome({Key? key}) : super(key: key);

  RefreshController refreshController = RefreshController(initialLoadStatus: LoadStatus.canLoading);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const WaterDropHeader(),
      footerBuilder: () => const ClassicFooter(),
      hideFooterWhenNotFull: true,
      headerTriggerDistance: 60,
      maxOverScrollExtent: 100,
      footerTriggerDistance: 150,
      child: Column(
        children: [
          const ColoredBox(
            color: Colors.grey,
            child: SizedBox(
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text('Home'),
              ),
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullUp: true,
              enablePullDown: true,
              controller: refreshController,
              onRefresh: () {
                Future.delayed(const Duration(seconds: 2), () {
                  refreshController.refreshCompleted();
                });
              },
              onLoading: () {
              },
              child: CustomScrollView(
                slivers: [
                  SliverHeader(child: Container(color: Colors.redAccent, alignment: Alignment.center, child: const Text('1'))),
                  SliverHeader(child: Container(color: Colors.grey, alignment: Alignment.center, child: const Text('2'))),
                  SliverHeader(child: Container(color: Colors.redAccent, alignment: Alignment.center, child: const Text('3'))),
                  SliverHeader(child: Container(color: Colors.grey, alignment: Alignment.center, child: const Text('4'))),
                  SliverHeader(child: Container(color: Colors.redAccent, alignment: Alignment.center, child: const Text('5'))),
                  // SliverHeader(child: Container(color: Colors.grey, alignment: Alignment.center, child: const Text('6'))),
                  // SliverHeader(child: Container(color: Colors.redAccent, alignment: Alignment.center, child: const Text('7'))),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        bool isDivider = index % 2 == 0;
                        return ColoredBox(
                          color: isDivider ? Colors.white : Colors.deepOrangeAccent,
                          child: SizedBox(
                            height: isDivider ? 1 : 50,
                          ),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
