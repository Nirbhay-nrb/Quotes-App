// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SearchButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  SearchButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColours.buttonBackg,
      height: 50,
      minWidth: 250,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: AppColours.textHeading,
            fontSize: 22,
            // fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
