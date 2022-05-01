import 'package:bytebank/components/dashboard_button.dart';
import 'package:flutter/material.dart';

bool dashboardButtonMatcher(Widget widget, String label, IconData icon) {
  return widget is DashboardButton &&
      widget.label == label &&
      widget.icon == icon;
}

bool textFieldMatcher(Widget widget, String label) {
  return widget is TextField && widget.decoration?.labelText == label;
}
