import 'package:flutter/material.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/singup_screen.dart';

class SignupRoute extends NuRoute {
  @override
  String get path => 'sign-up';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    return SingupScreen(
      onLoginClick: () => nuvigator.open('login'),
    );
  }
}
