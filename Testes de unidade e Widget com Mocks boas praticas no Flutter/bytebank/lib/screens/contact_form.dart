import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/widgets/app_dependecies.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  // final ContactDAO contactDAO;
  // _ContactFormState({required this.contactDAO});

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("New Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              style: const TextStyle(fontSize: 22),
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(labelText: "Account Number"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                  child: const Text("Create"),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int account = int.parse(_accountController.text);
                    final Contact newContact =
                        Contact(id: 0, name: name, accountNumber: account);
                    _save(dependencies.contactDAO, newContact, context);
                  },
                  style: const ButtonStyle(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(
      ContactDAO contactDAO, Contact newContact, BuildContext context) async {
    await contactDAO.save(newContact);
    Navigator.pop(context);
  }
}
