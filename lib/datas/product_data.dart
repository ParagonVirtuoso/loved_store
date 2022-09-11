import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String? category;
  String? id;
  String? title;
  String? description;
  double? preco;
  List? images;
  List? sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot["title"];
    description = snapshot["description"];
    preco = snapshot["preco"] + 0.0;
    images = snapshot["images"];
    sizes = snapshot["tamanho"];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "price": preco};
  }
}
