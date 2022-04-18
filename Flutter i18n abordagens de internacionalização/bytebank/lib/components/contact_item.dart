import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onTap;

  const ContactItem(this.contact, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onTap(),
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 22),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
