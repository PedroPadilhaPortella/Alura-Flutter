import 'package:bytebank/components/dashboard_button.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:flutter/material.dart';

bool dashboardButtonMatcher(Widget widget, String label, IconData icon) {
  return widget is DashboardButton &&
      widget.label == label &&
      widget.icon == icon;
}

bool textFieldMatcher(Widget widget, String label) {
  return widget is TextField && widget.decoration?.labelText == label;
}

bool contactItemMatcher(Widget widget, Contact contact) {
  return widget is ContactItem &&
      widget.contact.accountNumber == contact.accountNumber &&
      widget.contact.name == contact.name;
}
