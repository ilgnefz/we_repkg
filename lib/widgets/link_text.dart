import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatefulWidget {
  const LinkText({super.key, required this.label, required this.uri});

  final String label;
  final String uri;

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => _hover = true),
      onExit: (event) => setState(() => _hover = false),
      child: InkWell(
        onTap: () async => await launchUrl(Uri.parse(widget.uri)),
        hoverColor: Colors.transparent,
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            color: _hover
                ? Colors.blueAccent
                : Theme.of(context).textTheme.bodyMedium?.color,
            fontFamily: 'Microsoft YaHei',
          ),
        ),
      ),
    );
  }
}
