import 'package:bytebank/components/dashboard_button.dart';
import 'package:bytebank/models/name.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/dashboard/dashboard_i18n.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N i18N;

  const DashboardView(this.i18N, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
