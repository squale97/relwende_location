class PanierModel {
  int? code;
  List<Contenu>? contenu;
  String? title;

  PanierModel({this.code, this.contenu, this.title});

  PanierModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['contenu'] != null) {
      contenu = <Contenu>[];
      json['contenu'].forEach((v) {
        contenu!.add(Contenu.fromJson(v));
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
  int? id;
  List<Produits>? produits;
  String? statut;
  num? taille;
  num? total;

  Contenu({this.id, this.produits, this.statut, this.taille, this.total});

  Contenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['produits'] != null) {
      produits = <Produits>[];
      json['produits'].forEach((v) {
        produits!.add(new Produits.fromJson(v));
      });
    }
    statut = json['statut'];
    taille = json['taille'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.produits != null) {
      data['produits'] = this.produits!.map((v) => v.toJson()).toList();
    }
    data['statut'] = this.statut;
    data['taille'] = this.taille;
    data['total'] = this.total;
    return data;
  }
}

class Produits {
  int id = 0;
  String description = "";
  String extend = "";
  int index = 0;
  String libele = "";
  num prix = 0;
  String reference = "";
  int stock = 0;
  String couleur = "";
  int categorie = 0;
  String image = "";
  bool? isChecked = false;

  Produits(
      {required this.image,
      required this.libele,
      required this.description,
      required this.extend,
      required this.couleur,
      required this.prix,
      required this.index,
      required this.reference,
      required this.stock,
      required this.categorie,
      required this.id,
      required this.isChecked});

  Produits.fromJson(Map<String, dynamic> json) {
    categorie = json['categorie'];
    couleur = json['couleur'];
    description = json['description'];
    extend = json['extend'];
    id = json['id'];
    image = json['image'];
    index = json['index'];
    libele = json['libele'];
    prix = json['prix'];
    reference = json['reference'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categorie'] = this.categorie;
    data['couleur'] = this.couleur;
    data['description'] = this.description;
    data['extend'] = this.extend;
    data['id'] = this.id;
    data['image'] = this.image;
    data['index'] = this.index;
    data['libele'] = this.libele;
    data['prix'] = this.prix;
    data['reference'] = this.reference;
    data['stock'] = this.stock;
    return data;
  }
}
