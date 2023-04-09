class LoginModel {
  int? code;
  String? contenu;
  int? id;
  String? nom;
  String? prenom;
  String? title;

  LoginModel(
      {this.code, this.contenu, this.id, this.nom, this.prenom, this.title});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    contenu = json['contenu'];
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['contenu'] = this.contenu;
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['title'] = this.title;
    return data;
  }
}
