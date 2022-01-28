import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  String category;
  String id;
  String title;
  String description;
  double preco;
  List images;
  List sizes;


  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot.data()["title"];
    description = snapshot.data()["description"];
    preco = snapshot.data()["preco"] + 0.0;
    images = snapshot.data()["images"];
    sizes = snapshot.data()["tamanho"];

  }

  Map<String, dynamic> toResumedMap(){
    return {
      "title": title,
      "description": description,
      "price": preco
    };
  }

}