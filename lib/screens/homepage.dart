// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/route_names.dart';
import '../widgets/search_button.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/quotes_cropped.png'),
            ),
            Text(
              'Quotes',
              style: GoogleFonts.pacifico(
                fontSize: 50,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SearchButton(
              text: 'Search by Author',
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.searchAuthor);
              },
            ),
            SizedBox(
              height: 15,
            ),
            SearchButton(
              text: 'Search by Topics',
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.searchTopic);
              },
            ),
            SizedBox(
              height: 15,
            ),
            SearchButton(
              text: 'Favorites',
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.favoriteScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
