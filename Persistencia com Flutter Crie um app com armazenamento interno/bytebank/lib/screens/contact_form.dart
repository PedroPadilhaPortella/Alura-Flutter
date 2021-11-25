import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("New Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                label: Text("Full Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _accountController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  label: Text("Account Number"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                  child: Text("Create"),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int account = int.parse(_accountController.text);
                    final Contact newContact =
                        Contact(id: 0, name: name, accountNumber: account);
                    save(newContact).then((id) => Navigator.pop(context));
                  },
                  style: ButtonStyle(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
