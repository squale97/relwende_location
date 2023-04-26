class CommandeModel {
  int? code;
  List<Contenu>? contenu;
  String? title;

  CommandeModel({this.code, this.contenu, this.title});

  CommandeModel.fromJson(Map<String, dynamic> json) {
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
  String? addresseLivraison;
  String? date;
  String? dateEvenement;
  String? dateLivraison;
  int? dureeLocation;
  String? heure;
  String? heureLivraison;
  int? id;
  String? libele;
  List<Produits>? produits;
  int? quantite;
  String? statut;

  Contenu(
      {this.addresseLivraison,
      this.date,
      this.dateEvenement,
      this.dateLivraison,
      this.dureeLocation,
      this.heure,
      this.heureLivraison,
      this.id,
      this.libele,
      this.produits,
      this.quantite,
      this.statut});

  Contenu.fromJson(Map<String, dynamic> json) {
    addresseLivraison = json['addresseLivraison'];
    date = json['date'];
    dateEvenement = json['dateEvenement'];
    dateLivraison = json['dateLivraison'];
    dureeLocation = json['dureeLocation'];
    heure = json['heure'];
    heureLivraison = json['heureLivraison'];
    id = json['id'];
    libele = json['libele'];
    if (json['produits'] != null) {
      produits = <Produits>[];
      json['produits'].forEach((v) {
        produits!.add(new Produits.fromJson(v));
      });
    }
    quantite = json['quantite'];
    statut = json['statut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addresseLivraison'] = this.addresseLivraison;
    data['date'] = this.date;
    data['dateEvenement'] = this.dateEvenement;
    data['dateLivraison'] = this.dateLivraison;
    data['dureeLocation'] = this.dureeLocation;
    data['heure'] = this.heure;
    data['heureLivraison'] = this.heureLivraison;
    data['id'] = this.id;
    data['libele'] = this.libele;
    if (this.produits != null) {
      data['produits'] = this.produits!.map((v) => v.toJson()).toList();
    }
    data['quantite'] = this.quantite;
    data['statut'] = this.statut;
    return data;
  }
}

class Produits {
  String? description;
  int? id;
  int? idCategorie;
  String? image;
  String? libele;
  String? libeleCategorie;
  int? prix;
  String? reference;
  int? stock;
  int? index;

  Produits(
      {this.description,
      this.id,
      this.idCategorie,
      this.image,
      this.libele,
      this.libeleCategorie,
      this.prix,
      this.reference,
      this.index,
      this.stock});

  Produits.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    idCategorie = json['idCategorie'];
    image = json['image'];
    libele = json['libele'];
    libeleCategorie = json['libeleCategorie'];
    prix = json['prix'];
    reference = json['reference'];
    stock = json['stock'];
    index = json['index'];
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
    data['reference'] = this.reference;
    data['stock'] = this.stock;
    data['index'] = this.index;
    return data;
  }
}
