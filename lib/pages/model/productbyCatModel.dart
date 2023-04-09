class ProductByCategoryModel {
  int? code;
  List<Contenu>? contenu;
  String? title;

  ProductByCategoryModel({this.code, this.contenu, this.title});

  ProductByCategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['contenu'] != null) {
      contenu = <Contenu>[];
      json['contenu'].forEach((v) {
        contenu!.add(new Contenu.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.contenu != null) {
      data['contenu'] = this.contenu!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}

class Contenu {
  String? description;
  int? id;
  int? idCategorie;
  String? image;
  String? libele;
  String? libeleCategorie;
  int? prix;
  int? stock;

  Contenu(
      {this.description,
      this.id,
      this.idCategorie,
      this.image,
      this.libele,
      this.libeleCategorie,
      this.prix,
      this.stock});

  Contenu.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    idCategorie = json['idCategorie'];
    image = json['image'];
    libele = json['libele'];
    libeleCategorie = json['libeleCategorie'];
    prix = json['prix'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['idCategorie'] = this.idCategorie;
    data['image'] = this.image;
    data['libele'] = this.libele;
    data['libeleCategorie'] = this.libeleCategorie;
    data['prix'] = this.prix;
    data['stock'] = this.stock;
    return data;
  }
}
