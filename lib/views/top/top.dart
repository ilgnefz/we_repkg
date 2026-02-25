import 'package:flutter/material.dart';
import 'package:we_repkg/views/top/refresh.dart';
import 'package:we_repkg/views/top/search.dart';
import 'package:we_repkg/views/top/sort_dropdown.dart';
import 'package:we_repkg/views/top/sort_toggle.dart';
import 'package:we_repkg/views/top/title.dart';

class TopView extends StatelessWidget {
  const TopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopTitle(),
          SizedBox(width: 8),
          Refresh(),
          Spacer(),
          Search(),
          SizedBox(width: 8),
          SortToggle(),
          SizedBox(width: 4),
          SortDropdown(),
        ],
      ),
    );
  }
}
