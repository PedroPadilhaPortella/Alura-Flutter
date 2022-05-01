import 'package:bytebank/components/dashboard_button.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final ContactDAO contactDAO;

  const Dashboard({Key? key, required this.contactDAO}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
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
                          onClick: () => ContactList(contactDAO: contactDAO),
                        ),
                        DashboardButton(
                          label: "Transaction Feed",
                          icon: Icons.description,
                          onClick: () => TransactionsList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
