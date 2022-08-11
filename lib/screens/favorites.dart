// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/widgets/error_box.dart';

import '../constants.dart';
import '../providers/quotes.dart';
import '../widgets/input_field.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String target = '';

  @override
  void didChangeDependencies() {
    Provider.of<Quotes>(context, listen: false).getFavListFromLocal();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var quotesObject = Provider.of<Quotes>(context);
    return Scaffold(
      backgroundColor: AppColours.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        hintText: 'Search favorites',
                        onChanged: (value) {
                          setState(() {
                            target = value;
                          });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            target = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: quotesObject.favs(target).length,
                    itemBuilder: (context, i) => Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: AppColours.background,
                          child: Column(
                            children: [
                              Text(
                                quotesObject.favs(target)[i].quote,
                                style: GoogleFonts.oxygen(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    quotesObject.favs(target)[i].author,
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      quotesObject.toggleFav(
                                        quotesObject.favs(target)[i].id,
                                      );
                                    },
                                    icon: Icon(
                                      quotesObject.favs(target)[i].isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    'Delete all favorites??',
                    style: GoogleFonts.lato(
                      color: AppColours.subtext,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => ErrorBox(
                        error:
                            'Are you sure you want to delete all your favorites?',
                        onPressed: () {
                          quotesObject.clearFavs();
                          Navigator.pop(context);
                        },
                        buttonText: 'Yes',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
