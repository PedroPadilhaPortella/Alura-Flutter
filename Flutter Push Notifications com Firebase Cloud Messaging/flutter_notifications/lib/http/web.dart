import 'dart:convert';
import 'package:meetups/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/device.dart';

const String baseUrl = 'http://192.168.15.10:8080/api';

Future<List<Event>> getAllEvents() async {
  final response = await http.get(Uri.parse('$baseUrl/events'));

  if (response.statusCode == 200) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Event.fromJson(json)).toList();
  } else {
    throw Exception('Falha ao carregar os eventos');
  }
}

sendDevice(Device device) async {
  final response = await http.post(
    Uri.parse('$baseUrl/devices'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{
      'token': device.token ?? '',
      'modelo': device.model ?? '',
      'marca': device.brand ?? '',
    }),
  );

  // Valida se o token já foi enviado ou não
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('pushToken', device.token!);
  preferences.setBool('tokenSent', false);

  if (response.statusCode != 200)
    throw Exception('Falha para criar o dispositivo');
  else {
    preferences.setBool('tokenSent', true);
  }

  return response;
}
