import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String _title;
  final Color _theme;

  const MainTitle(
      {Key? key, String title = "DEFAULT", Color theme = Colors.black})
      : _title = title,
        _theme = theme,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: _theme,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
