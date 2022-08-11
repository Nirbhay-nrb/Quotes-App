// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/widgets/error_box.dart';

import '../constants.dart';
import '../widgets/input_field.dart';
import '../providers/quotes.dart';

class SearchByTopic extends StatefulWidget {
  @override
  State<SearchByTopic> createState() => _SearchByTopicState();
}

class _SearchByTopicState extends State<SearchByTopic> {
  String topics = '';

  int limit = 10;

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
                        hintText: 'Enter any topic',
                        onChanged: (value) {
                          topics = value;
                        },
                        onSubmitted: (value) async {
                          try {
                            await quotesObject.searchByTopic(
                              topics: topics,
                              limit: limit,
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (ctx) => ErrorBox(
                                error: 'Some error occured',
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
                          print(topics);
                          await quotesObject.searchByTopic(
                            topics: topics,
                            limit: limit,
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (ctx) => ErrorBox(
                              error: 'Some error occured',
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
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: quotesObject.quoteCount(),
                    itemBuilder: (context, i) => Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: AppColours.background,
                          child: Column(
                            children: [
                              Text(
                                quotesObject.quotes[i].quote,
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
                                    quotesObject.quotes[i].author,
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      quotesObject
                                          .toggleFav(quotesObject.quotes[i].id);
                                    },
                                    icon: Icon(
                                      quotesObject.quotes[i].isFav
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
