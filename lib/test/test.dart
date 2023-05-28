import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();

  @override
  Widget build(BuildContext context) {
    Future<void> handleRefresh() {
      final Completer<void> completer = Completer<void>();
      Timer(const Duration(seconds: 3), () {
        completer.complete();
      });
      return completer.future.then<void>((_) {
        ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
          SnackBar(
            content: const Text('Refresh complete'),
            action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState!.show();
              },
            ),
          ),
        );
      });
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepPurple[200],
      body: LiquidPullToRefresh(
        onRefresh: handleRefresh,
        child: ListView.separated(
            itemBuilder: (context,index) => SizedBox(),
            separatorBuilder: (context,index) => SizedBox(),
            itemCount: 5,
        ),
      ),
    );
  }
}
