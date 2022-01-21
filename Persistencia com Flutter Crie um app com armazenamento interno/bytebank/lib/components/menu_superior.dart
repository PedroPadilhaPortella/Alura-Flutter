import 'package:flutter/material.dart';

class MenuSuperior extends StatelessWidget {
  final String title;
  final Color backgroundColor;

  const MenuSuperior(
      {Key? key, required this.title, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: backgroundColor, title: Text(title));
  }
}
