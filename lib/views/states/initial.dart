import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:we_repkg/constants/i10n.dart';
import 'package:we_repkg/widgets/ellipsis_animation_text.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 80, height: 80, child: CircularProgressIndicator()),
            EllipsisAnimationText(text: tr(AppI10n.loading)),
          ],
        ),
      ),
    );
  }
}
