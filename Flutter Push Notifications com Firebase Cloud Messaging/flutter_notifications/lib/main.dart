import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meetups/http/web.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Notificações ios precisam de permissões dadas pelos usuários
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('Permissão concedida pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationHandler(messaging);
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print(
        'Permissão concedida provisóriamente pelo usuário: ${settings.authorizationStatus}');
    _startPushNotificationHandler(messaging);
  } else {
    print('Permissão negada pelo usuário');
  }

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev meetups',
      home: EventsScreen(),
      navigatorKey: navigatorKey,
    );
  }
}

void _startPushNotificationHandler(FirebaseMessaging messaging) async {
  //Obter token do dispositivo
  String? token = await messaging.getToken(
      vapidKey:
          'BJb23_NXZP_xj2V1DKcX_xES6KJRdZUkUpTYB_pmEsJfhTsWsebGTH6lmVwDwoTtFc_eKF8Llz2PlltSKdc5XC4');
  _setPushToken(token!);

  //Mensagem em Foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Recebi uma mensagem enquanto estava em primeiro plano!');
    print('Dados da mensagem: ${message.data}');

    if (message.notification != null) {
      print(
          'A mensagem contém uma notificação: ${message.notification!.title}, ${message.notification!.body}');
    }
  });

  // Background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Mensagem que inicializa o app
  var notification = await FirebaseMessaging.instance.getInitialMessage();

  // if (notification!.data["message"].length > 0) {
  showMyDialog(notification?.data["message"]);
  // }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Mensagem recebida em background: ${message.notification}");
}

void _setPushToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? preferencesToken = preferences.getString('pushToken');
  bool preferencesSent = preferences.getBool('tokenSent') ?? false;
  print('preferencesToken: $preferencesToken');
  print('preferencesSent: $preferencesSent');

  if (preferencesToken != token ||
      (preferencesToken == token && preferencesSent == false)) {
    print('Enviando o token para o servidor');

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? brand;
    String? model;

    // Mostrar os vários tipos de tratamento que existem
    // https://github.com/fluttercommunity/plus_plugins/blob/main/packages/device_info_plus/device_info_plus/example/lib/main.dart#L43

    // Explicar os tipos de notificações:
    // - Dados
    //    Foreground e background
    // - Notificação
    //       Terminated

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(androidInfo.model);
      brand = androidInfo.brand;
      model = androidInfo.model;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo.model);
      model = iosInfo.utsname.machine;
      brand = 'Apple';
    }

    Device device = Device(token: token, brand: brand, model: model);
    sendDevice(device);
  }
}

void showMyDialog(String message) {
  print('showMyDialog: $message');
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) => AlertDialog(
      title: Text("Você recebeu uma mensagem"),
      content: Text(message),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(navigatorKey.currentContext!),
          child: Text('Ok'),
        ),
      ],
    ),
  );
}
