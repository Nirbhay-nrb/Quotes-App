// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'quote.dart';

class Quotes with ChangeNotifier {
  final List<Quote> _quotes = [];
  final List<Quote> _favs = [];

  Quote _quote = Quote(
    id: '',
    quote: '',
    author: '',
    authorId: '',
  );

  List<Quote> get quotes {
    return [..._quotes];
  }

  List<Quote> favs(String target) {
    if (target == '') {
      return [..._favs];
    } else {
      return _favs
          .where((element) =>
              element.quote.toLowerCase().contains(target.toLowerCase()))
          .toList();
    }
  }

  Quote get quote {
    return _quote;
  }

  int quoteCount() {
    return _quotes.length;
  }

  Future<void> searchByAuthor(String author) async {
    var url = Uri.parse(
        'https://api.quotable.io/search/quotes?query=$author&fields=author');
    print(url);
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      // initialise quote
      if (responseData["count"] != 0) {
        _quote = Quote(
          id: responseData["results"][0]["_id"],
          author: responseData["results"][0]["author"],
          authorId: responseData["results"][0]["authorId"],
          quote: responseData["results"][0]["content"],
        );
        print(quote);
        notifyListeners();
      } else {
        throw 'No such author exists';
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> searchByTopic({String topics = '', int limit = 10}) async {
    var url = Uri.parse(
        'https://api.quotable.io/search/quotes?query=$topics&limit=${limit.toString()}');
    print(url);
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["count"] != 0) {
        for (int i = 0; i < limit; i++) {
          var newQuote = Quote(
            id: responseData["results"][i]["_id"],
            author: responseData["results"][i]["author"],
            authorId: responseData["results"][i]["authorId"],
            quote: responseData["results"][i]["content"],
          );
          _quotes.add(newQuote);
        }
        notifyListeners();
      } else {
        throw 'Error';
      }
      notifyListeners();
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  void toggleFav(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String s = preferences.getString(id).toString();
    var q = json.decode(s);
    Quote quote;
    if (q != null) {
      quote = Quote(
        id: q["id"],
        quote: q["quote"],
        author: q["author"],
        authorId: q["authorId"],
        isFav: !q["isFav"],
      );
    } else {
      quote = Quote(
        id: '',
        quote: '',
        author: '',
        authorId: '',
      );
    }
    if (_quote.id != '') {
      _quote = Quote(
        id: _quote.id,
        author: _quote.author,
        authorId: _quote.authorId,
        quote: _quote.quote,
        isFav: !_quote.isFav,
      );
      quote = _quote;
    }

    var index = _quotes.indexWhere((element) => element.id == id);
    print(index);
    if (index != -1) {
      _quotes[index] = Quote(
        id: _quotes[index].id,
        author: _quotes[index].author,
        authorId: _quotes[index].authorId,
        quote: _quotes[index].quote,
        isFav: !_quotes[index].isFav,
      );
      quote = _quotes[index];
    }

    if (quote.isFav) {
      print('adding to favorites');
      _favs.add(quote);
      addToLocal(quote);
    } else {
      print('deleteing from favorites');
      _favs.removeWhere((element) => element.id == quote.id);
      deleteFromLocal(quote);
    }
    notifyListeners();
  }

  void clearFavs() async {
    for (int i = 0; i < _favs.length; i++) {
      if (_quote.id == _favs[i].id) {
        _quote = Quote(
          id: _quote.id,
          author: _quote.author,
          authorId: _quote.authorId,
          quote: _quote.quote,
          isFav: !_quote.isFav,
        );
      }
      var index = _quotes.indexWhere((element) => element.id == _favs[i].id);
      if (index != -1) {
        _quotes[index] = Quote(
          id: _quotes[index].id,
          author: _quotes[index].author,
          authorId: _quotes[index].authorId,
          quote: _quotes[index].quote,
          isFav: !_quotes[index].isFav,
        );
      }
    }
    _favs.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    notifyListeners();
  }

  void addToLocal(Quote quote) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
      quote.id,
      json.encode(
        {
          "id": quote.id,
          "author": quote.author,
          "authorId": quote.authorId,
          "quote": quote.quote,
          "isFav": quote.isFav,
        },
      ),
    );
  }

  void deleteFromLocal(Quote quote) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(quote.id);
  }

  void getFavListFromLocal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> keys = preferences.getKeys().toList();
    _favs.clear();
    for (int i = 0; i < keys.length; i++) {
      String s = preferences.getString(keys[i]).toString();
      var q = json.decode(s);
      _favs.add(
        Quote(
          id: q["id"],
          quote: q["quote"],
          author: q["author"],
          authorId: q["authorId"],
          isFav: q["isFav"],
        ),
      );
    }
    notifyListeners();
  }
}
