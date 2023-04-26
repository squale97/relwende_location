import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController Subject = TextEditingController();
  //TextEditingController name = TextEditingController();
  TextEditingController corps = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3b22a1),
        title: Text(
          'Contactez nous',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informations de contact',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /*Uri phoneno = Uri.parse('tel:+97798345348734');
                      if (await launchUrl(phoneno)) {
                          //dialer opened
                      }else{
                          //dailer is not opened
                      }*/
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 8.0),
                    TextButton(
                        onPressed: () async {
                          Uri phoneno = Uri.parse('tel:+226 60 59 37 39');
                          if (await launchUrl(phoneno)) {
                            //dialer opened
                          } else {
                            //dailer is not opened
                          }
                        },
                        child: Text(
                          '+226 60 59 37 39',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        )),
                    TextButton(
                      onPressed: () async {
                        Uri phoneno = Uri.parse('tel:+226 65 34 99 83');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                      child: Text("+226 65 34 99 83",
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                    )
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 8.0),
                    Text(
                      'support@example.com',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8.0),
                    Text(
                      "Ouaga, Patte d'oie",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Envoyer nous un message',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "nom"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "object"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                    }
                    return null;
                  },
                  controller: Subject,
                  decoration: InputDecoration(
                    labelText: 'objet',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "message"; //dropdownvalue=='Français'?"Veuillez entrer le mot de passe":"Please enter the password";
                    }
                    return null;
                  },
                  controller: corps,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3b22a1),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = Uri.encodeComponent("relwende@gmail.com");
                      String subject = Uri.encodeComponent(Subject.text);
                      String body = Uri.encodeComponent(corps.text);
                      print(subject); //output: Hello%20Flutter
                      Uri mail = Uri.parse(
                          "mailto:$email?subject=$subject&body=$body");
                      if (await launchUrl(mail)) {
                        //email app opened
                      } else {
                        //email app is not opened
                      }
                    }
                  },
                  child: Text('Envoyer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// for ios
/*Project > ios > Runner > Info.plist

<key>LSApplicationQueriesSchemes</key>
<array>
  <string>https</string>
  <string>http</string>
</array>
*/