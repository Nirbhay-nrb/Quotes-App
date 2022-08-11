// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/quotes.dart';
import '../widgets/error_box.dart';
import '../widgets/input_field.dart';

class SearchByAuthor extends StatefulWidget {
  @override
  State<SearchByAuthor> createState() => _SearchByAuthorState();
}

class _SearchByAuthorState extends State<SearchByAuthor> {
  String author = '';

  @override
  Widget build(BuildContext context) {
    var quotesObject = Provider.of<Quotes>(context);
    return Scaffold(
      backgroundColor: AppColours.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      hintText: 'Enter the name of the author',
                      onChanged: (value) {
                        author = value;
                      },
                      onSubmitted: (value) async {
                        print(author);
                        try {
                          await quotesObject.searchByAuthor(author);
                        } catch (e) {
                          print(e);
                          showDialog(
                            context: context,
                            builder: (ctx) => ErrorBox(
                              error: 'No such author exists',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              buttonText: 'Okay',
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    color: AppColours.iconColours,
                    onPressed: () async {
                      try {
                        await quotesObject.searchByAuthor(author);
                      } catch (e) {
                        print(e);
                        showDialog(
                          context: context,
                          builder: (ctx) => ErrorBox(
                            error: 'No such author exists',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            buttonText: 'Okay',
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Visibility(
                visible: quotesObject.quote.id != '',
                child: Column(
                  children: [
                    Text(
                      quotesObject.quote.quote,
                      style: GoogleFonts.oxygen(
                        fontSize: 24,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '- ${quotesObject.quote.author}',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            quotesObject.toggleFav(quotesObject.quote.id);
                          },
                          icon: Icon(
                            quotesObject.quote.isFav
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
