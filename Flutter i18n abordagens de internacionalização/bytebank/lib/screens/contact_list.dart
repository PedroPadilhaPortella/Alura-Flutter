import 'package:bytebank/components/contact_item.dart';
import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class ContactListState {
  const ContactListState();
}

@immutable
class InitContactListState extends ContactListState {
  const InitContactListState();
}

@immutable
class LoadingContactListState extends ContactListState {
  const LoadingContactListState();
}

@immutable
class LoadedContactListState extends ContactListState {
  final List<Contact> _contacts;
  const LoadedContactListState(this._contacts);
}

@immutable
class FatalErrorContactListState extends ContactListState {
  const FatalErrorContactListState();
}

class ContactListCubit extends Cubit<ContactListState> {
  ContactListCubit() : super(const InitContactListState());

  void reload(ContactDAO contactDAO) async {
    emit(const LoadingContactListState());
    contactDAO
        .findAll()
        .then((contacts) => emit(LoadedContactListState(contacts)));
  }
}

class ContactListContainer extends BlocContainer {
  const ContactListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactDAO _contactDAO = ContactDAO();

    return BlocProvider<ContactListCubit>(
        create: (BuildContext context) {
          final cubit = ContactListCubit();
          cubit.reload(_contactDAO);
          return cubit;
        },
        child: ContactList(_contactDAO));
  }
}

class ContactList extends StatelessWidget {
  final ContactDAO contactDAO;
  const ContactList(this.contactDAO, {Key? key}) : super(key: key);

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ContactForm()),
        ); // .then((value) => setState(() {}));
        update(context);
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void update(BuildContext context) {
    context.read<ContactListCubit>().reload(contactDAO);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Transfer"),
        ),
        body: BlocBuilder<ContactListCubit, ContactListState>(
          builder: (context, state) {
            if (state is InitContactListState ||
                state is LoadingContactListState) {
              return const Progress();
            }
            if (state is LoadedContactListState) {
              final List<Contact> contacts = state._contacts;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactItem(
                    contacts[index],
                    onTap: () => push(context,
                        () => TransactionFormContainer(contacts[index])),
                    // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         TransactionFormContainer(contacts[index]))),
                  );
                },
              );
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
        floatingActionButton: buildAddContactButton(context));
  }
}
