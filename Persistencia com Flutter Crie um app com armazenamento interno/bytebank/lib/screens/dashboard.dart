import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/dashboard_button.dart';
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
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text("Welcome $state"),
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
                    label: "Transfer",
                    icon: Icons.monetization_on,
                    onClick: () => const ContactListContainer(),
                  ),
                  DashboardButton(
                    label: "Transaction Feed",
                    icon: Icons.description,
                    onClick: () => TransactionsList(),
                  ),
                  DashboardButton(
                    label: "Change Name",
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
