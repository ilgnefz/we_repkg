import 'package:flutter/material.dart';

class ImageTitle extends StatelessWidget {
  const ImageTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        // constraints: BoxConstraints(maxHeight: 40),
        height: 24,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.black.withValues(alpha: .4)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Microsoft YaHei',
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
