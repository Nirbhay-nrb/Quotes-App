// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final Function onSubmitted;
  InputField({
    required this.hintText,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      style: GoogleFonts.lato(
        color: Colors.black,
        fontSize: 18,
      ),
      onChanged: (value) {
        onChanged(value);
      },
      onSubmitted: (value) {
        onSubmitted(value);
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          color: Colors.black54,
          fontSize: 18,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
