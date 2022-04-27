import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:http/http.dart';

class I18NWebClient {
  final String url =
      'https://gist.githubusercontent.com/PedroPadilhaPortella/953a2292d26fbcff766562e7c4accd0e/raw/c88989dfdc6735906ded069921840a62d5253f1a';
  final String viewKey;

  I18NWebClient(this.viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Uri uri = Uri.parse('$url/$viewKey.json');
    final Response response = await client.get(uri);
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}
