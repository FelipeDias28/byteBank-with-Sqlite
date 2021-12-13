import 'package:flutter/material.dart';
import 'package:new_byte_bank/database/app_database.dart';
import 'package:new_byte_bank/models/contact.dart';
import 'package:new_byte_bank/screens/contact_form.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // Quando o future ainda naão foi executado.
            case ConnectionState.none:
              break;
            // Quando ainda esta carregando e não foi iniciado.
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Loading')
                  ],
                ),
              );
            // Quando o snapshot já tem as informações mas o future ainda não foi carregado
            case ConnectionState.active:
              break;
            // Devolver a Lista
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data as List<Contact>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(contact: contact);
                },
                itemCount: contacts.length,
              );
          }
          return const Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ContactForm(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name.toString(),
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contact.accountNummber.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
