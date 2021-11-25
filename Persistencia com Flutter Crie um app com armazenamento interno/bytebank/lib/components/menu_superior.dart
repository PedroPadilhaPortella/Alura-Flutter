import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MenuSuperior extends StatelessWidget {
  final String title;
  final Color backgroundColor;

  MenuSuperior({required this.title, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text("$title")
    );
  }
}
