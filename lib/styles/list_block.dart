import 'package:flutter/material.dart';

class ListBlock extends StatelessWidget {
  Widget start;
  Widget center;
  Widget end;
  ListBlock({
    Key? key,
    this.start = const SizedBox(),
    required this.center,
    this.end = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [start, Expanded(child: center), end],
    );
  }
}
