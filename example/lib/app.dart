import 'package:example/page/pages_manager.dart';
import 'package:example/util/logger.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    Logger.d('>>>>>>>>>>>>>>>>>> $runtimeType initState');
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Logger.d('>>>>>>>>>>>>>>>>>> $runtimeType addPostFrameCallback ${timeStamp.inSeconds}');
      PagesManager.init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Logger.d('>>>>>>>>>>>>>>>>>> $runtimeType dispose');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Logger.d('>>>>>>>>>>>>>>>>>> $runtimeType build');
    PagesManager.appContext = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PagesManager.getAppBody(),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Logger.d('>>>>>>>>>>>>>>>>>> didChangeAppLifecycleState: $state');
  }
}
