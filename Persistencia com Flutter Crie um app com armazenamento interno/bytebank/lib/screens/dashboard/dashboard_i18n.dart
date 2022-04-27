import 'package:bytebank/components/localization/eager_localization.dart';
import 'package:bytebank/components/localization/i18n_messages.dart';
import 'package:flutter/material.dart';

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get transfer =>
      localize({"pt-br": "Tranferir", "en": "Transfer", 'ja': '移行'});

  String get transactionFeed => localize({
        "pt-br": "Histórico de Transações",
        "en": "Transaction Feed",
        'ja': '取引履歴'
      });

  String get changeName =>
      localize({"pt-br": "Alterar Nome", "en": "Change Name", 'ja': '名前を変更する'});

  String get welcome =>
      localize({"pt-br": "Bem Vindo", "en": "Welcome", 'ja': 'ようこそ'});
}

class DashboardViewLazyI18N {
  final I18NMessages messages;

  DashboardViewLazyI18N(this.messages);

  String get transfer => messages.get('transfer');

  String get transactionFeed => messages.get('transaction_feed');

  String get changeName => messages.get('change_name');

  String get welcome => messages.get('welcome');
}
