import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/dashboard_button.dart';
import 'package:bytebank/components/localization.dart';
import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Usuário'),
      child: I18NLoadingContainer(
        viewKey: 'dashboard',
        creator: (messages) => DashboardView(DashboardViewLazyI18N(messages)),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N i18N;

  const DashboardView(this.i18N, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final i18N = Dashboardi18N(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text("${i18N.welcome} $state"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/bytebank_logo.png'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DashboardButton(
                    label: i18N.transfer,
                    icon: Icons.monetization_on,
                    onClick: () => const ContactListContainer(),
                  ),
                  DashboardButton(
                    label: i18N.transactionFeed,
                    icon: Icons.description,
                    onClick: () => TransactionsList(),
                  ),
                  DashboardButton(
                    label: i18N.changeName,
                    icon: Icons.person_outline,
                    onClick: () => const NameContainer(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
