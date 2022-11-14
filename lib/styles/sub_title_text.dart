import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  final String _title;
  final double _size;
  final Color _theme;

  const SubTitle(
      {Key? key,
      String title = "default",
      double size = 15,
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
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
