class UserModel {
  int? code;
  List<Contenu>? contenu;
  String? title;

  UserModel({this.code, this.contenu, this.title});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? contact;
  String? email;
  int? id;
  String? nom;
  String? prenom;

  Contenu({this.contact, this.email, this.id, this.nom, this.prenom});

  Contenu.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    email = json['email'];
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    return data;
  }
}
