import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../controllers/contact_controller.dart';
import '../models/contact.dart';

class ContactsScreen extends StatelessWidget {
  final ContactController contactController = ContactController();

  ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contatos')),
      body: StreamBuilder<List<Contact>>(
        stream: contactController.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum contato encontrado.'));
          }

          final contatos = snapshot.data!;
          return ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              final contato = contatos[index];
              return ListTile(
                title: Text(contato.nome),
                subtitle: Text(contato.telefone),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showContactDialog(context, contato);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        contactController.deleteContact(contato.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactDialog(context, null);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Aqui aparece um pop-up para atualizar o contato
  void _showContactDialog(BuildContext context, Contact? contato) {
    final TextEditingController nomeController =
        TextEditingController(text: contato?.nome ?? '');
    final TextEditingController telefoneController =
        TextEditingController(text: contato?.telefone ?? '');
    final TextEditingController enderecoController = 
        TextEditingController(text: contato?.endereco ?? '');

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: Text(contato == null ? 'Novo Contato' : 'Editar Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),

              TextField(
                controller: telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
              ),

              TextField(
                controller: enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
              )

            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),

            ElevatedButton(
              onPressed: () {
                if (contato == null) {
                  contactController.addContact(
                    nomeController.text,
                    telefoneController.text,
                    enderecoController.text,
                  );
                } else {
                  contactController.updateContact(
                    contato.id,
                    nomeController.text,
                    telefoneController.text,
                    enderecoController.text,
                  );
                }
                Navigator.pop(context);
              },

              child: Text(contato == null ? 'Salvar' : 'Atualizar'),
            ),

          ],
        );
      },
    );
  }
}
