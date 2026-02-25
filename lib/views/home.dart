import 'package:flutter/material.dart';
import 'package:we_repkg/views/title_bar/window_title_bar.dart';
import 'package:window_manager/window_manager.dart';

import 'bottom/bottom.dart';
import 'content/content.dart';
import 'side.dart';
import 'top/top.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToResizeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            WindowTitleBar(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [TopView(), ContentView(), BottomView()],
                    ),
                  ),
                  SideView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
