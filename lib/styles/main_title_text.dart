import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String _title;
  final double _size;
  final Color _theme;
  final TextOverflow overflow;

  const MainTitle({
    Key? key,
    String title = "DEFAULT",
    double size = 36,
    Color theme = Colors.black,
    this.overflow = TextOverflow.ellipsis,
  })  : _title = title,
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
        fontFamily: 'Roboto',
        overflow: overflow,
      ),
    );
  }
}
