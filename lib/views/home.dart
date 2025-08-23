import 'package:flutter/material.dart';
import 'package:we_repkg/views/bottom.dart';
import 'package:we_repkg/views/side.dart';
import 'package:we_repkg/views/title_bar/window_title_bar.dart';
import 'package:we_repkg/views/top/top.dart';

import 'content/content.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
