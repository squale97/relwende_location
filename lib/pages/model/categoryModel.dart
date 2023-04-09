class CategoryModel {
  int? code;
  List<Contenu>? contenu;
  String? title;

  CategoryModel({this.code, this.contenu, this.title});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? image;
  String? libele;

  Contenu({this.id, this.image, this.libele});

  Contenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    libele = json['libele'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['libele'] = this.libele;
    return data;
  }
}
