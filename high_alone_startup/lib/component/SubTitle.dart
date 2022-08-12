import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  final String _title;
  final Color _theme;

  const SubTitle(
      {Key? key, String title = "default", Color theme = Colors.black})
      : _title = title,
        _theme = theme,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        color: _theme,
      ),
    );
  }
}
