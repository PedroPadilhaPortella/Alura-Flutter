import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';

class I18NWebClient {
  final Uri url = Uri.parse(
      'https://gist.githubusercontent.com/PedroPadilhaPortella/953a2292d26fbcff766562e7c4accd0e/raw/caeca2c91a5cfbf68cba91edc52f128dc13c74a8/i18N.json');

  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get(url);
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}
