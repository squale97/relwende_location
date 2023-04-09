import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildCategory(
  String categoryImage,
  String categoryName,
  Color firstColor,
  Color secondColor,
  Size size,
) {
  return Column(children: [
    CircleAvatar(
        backgroundColor: Color(0xff3b22a1),
        radius: 35,
        //backgroundColor: Color(0xff3b22a1),
        // height: size.width * 0.08,
        //width: size.width * 0.18,
        /*decoration: BoxDecoration(
          color: secondColor,
          border: Border.all(
            color: firstColor,
            width: 1,
          ),*/
        //  borderRadius: const BorderRadius.all(
        //Radius.circular(8),

        child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              categoryImage,
              //width: 10,
              // height: 10,
            ))),
    SizedBox(
      height: 5,
    ),
    Text(
      categoryName,
      style: GoogleFonts.lato(
        color: firstColor,
        //fontSize: size.height * 0.015,
      ),
    )
  ]);
}
