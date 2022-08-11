// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ErrorBox extends StatelessWidget {
  final String error;
  final Function onPressed;
  final String buttonText;
  ErrorBox({
    required this.error,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(error),
      elevation: 8,
      backgroundColor: AppColours.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      actions: [
        MaterialButton(
          color: AppColours.buttonBackg,
          height: 30,
          minWidth: 50,
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
              buttonText,
              style: GoogleFonts.poppins(
                color: AppColours.textHeading,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
