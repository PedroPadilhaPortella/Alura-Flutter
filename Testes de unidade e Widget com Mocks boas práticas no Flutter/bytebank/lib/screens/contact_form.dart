import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final ContactDAO contactDAO;

  const ContactForm({Key? key, required this.contactDAO}) : super(key: key);

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
                    _save(newContact, context);
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

  void _save(Contact newContact, BuildContext context) async {
    await widget.contactDAO.save(newContact);
    Navigator.pop(context);
  }
}
