import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/models/contact.dart';

class ContactList extends StatefulWidget {
  ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDAO _contactDAO = ContactDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Transfer"),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _contactDAO.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.green),
                    Text("Loading", style: TextStyle(fontSize: 24))
                  ],
                ),
              );
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data as List<Contact>;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactItem(contacts[index]);
                },
              );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
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

  ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 22),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
