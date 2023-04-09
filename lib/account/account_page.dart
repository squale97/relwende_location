import 'package:flutter/material.dart';

class EditInfosPage extends StatefulWidget {
  /* String? nom;
  String? prenom;
  String? email;
  String? num_telephone;
  String? cnib;
  EditInfosPage({
    this.nom,
    this.prenom,
    this.email,
    this.num_telephone,
    this.cnib,
  });
*/
  @override
  State<EditInfosPage> createState() => _EditInfosPageState();
}

class _EditInfosPageState extends State<EditInfosPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _prenomController = new TextEditingController();
  TextEditingController _cnibController = new TextEditingController();
  TextEditingController _telephoneController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes infos infos"),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
                width: 600,
                child: Column(
                  children: [
                    Text("Modifier les infos"),
                    SizedBox(
                      height: 15,
                    ),
                    Row(children: [
                      Flexible(
                        child: TextFormField(
                          //initialValue: widget.nom,
                          controller: _nameController..text = "nom",
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                              labelText: "nom",
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "nom";
                            }
                            return null;
                          },
                          //onSaved: (input)=>_title,
                        ),
                        // padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextFormField(
                          //initialValue: widget.nom,
                          controller: _prenomController..text = "prenom",
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                              labelText: "Prénom",
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Prénom";
                            }
                            return null;
                          },
                          //onSaved: (input)=>_title,
                        ),
                        // padding: EdgeInsets.symmetric(vertical: 20.0),
                      )
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Flexible(
                        child: TextFormField(
                          //initialValue: widget.nom,
                          controller: _telephoneController..text = "tel",
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                              labelText: "numero de telephone",
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "numero de telephone";
                            }
                            return null;
                          },
                          //onSaved: (input)=>_title,
                        ),
                        // padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: TextFormField(
                          //initialValue: widget.nom,
                          controller: _cnibController..text = "aaa",
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                              labelText: "cnib",
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Cnib";
                            }
                            return null;
                          },
                          //onSaved: (input)=>_title,
                        ),
                        // padding: EdgeInsets.symmetric(vertical: 20.0),
                      )
                    ])
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
