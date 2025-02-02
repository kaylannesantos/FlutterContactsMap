class Contact {
  String id;
  String nome;
  String telefone;
  String endereco;

  Contact({required this.id, required this.nome, required this.telefone, required this.endereco});

  // Converte um doc Firestore em um objeto Contact
  factory Contact.fromMap(Map<String, dynamic> data, String documentId) {
    return Contact(
      id: documentId,
      nome: data['nome'] ?? '',
      telefone: data['telefone'] ?? '',
      endereco: data['endereco'] ?? '',
    );
  }

  // Converte um objeto Contact em um mapa para armazenar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'telefone': telefone,
      'endereco': endereco,
    };
  }
}
