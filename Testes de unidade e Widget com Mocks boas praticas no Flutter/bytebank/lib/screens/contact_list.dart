import 'package:bytebank/components/progress.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/widgets/app_dependecies.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/models/contact.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Transfer"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: dependencies.contactDAO.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data as List<Contact>;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactItem(
                    contacts[index],
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TransactionForm(contacts[index]))),
                  );
                },
              );
            case ConnectionState.none:
              break;
            case ConnectionState.active:
              break;
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.block_rounded,
                  color: Colors.red,
                  size: 30,
                ),
                Text(
                  "Erro ao buscar dados",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              )
              .then((value) => setState(() {}));
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

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
