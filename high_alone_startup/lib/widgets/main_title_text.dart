import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String _title;
  final double _size;
  final Color _theme;

  const MainTitle(
      {Key? key,
      String title = "DEFAULT",
      double size = 36,
      Color theme = Colors.black})
      : _title = title,
        _size = size,
        _theme = theme,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: _theme,
        fontSize: _size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
