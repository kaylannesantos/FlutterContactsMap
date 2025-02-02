import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';

class ContactController {
  final CollectionReference contactsCollection =
      FirebaseFirestore.instance.collection('contatos');

  // Listar contatos
  Stream<List<Contact>> getContacts() {
    return contactsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Contact.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Cadastrar um novo contato
  Future<void> addContact(String nome, String telefone, String endereco) async {
    await contactsCollection.add({'nome': nome, 'telefone': telefone,'endereco': endereco});
  }

  // Atualizar um contato existente
  Future<void> updateContact(String id, String nome, String telefone, String endereco) async {
    await contactsCollection.doc(id).update({'nome': nome, 'telefone': telefone, 'endereco': endereco});
  }

  // Excluir um contato
  Future<void> deleteContact(String id) async {
    await contactsCollection.doc(id).delete();
  }
}
