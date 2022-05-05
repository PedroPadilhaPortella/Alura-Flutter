import 'package:flutter/material.dart';
import 'package:nuvigator/next.dart';
import 'package:proj/screens/profile_screen.dart';

class ProfileRoute extends NuRoute {
  @override
  String get path => 'profile';

  @override
  ScreenType get screenType => materialScreenType;

  @override
  Widget build(BuildContext context, NuRouteSettings<Object> settings) {
    print("Parametros recebido = ${settings.rawParameters['name']}");
    return ProfileScreen(
        onClose: () => nuvigator.pop(settings.rawParameters['name']));
  }
}
