import 'package:flutter/material.dart';

import '../routes/route_names.dart';

import '../screens/favorites.dart';
import '../screens/homepage.dart';
import '../screens/search_author.dart';
import '../screens/search_topic.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteNames.searchAuthor:
        return MaterialPageRoute(builder: (_) => SearchByAuthor());
      case RouteNames.searchTopic:
        return MaterialPageRoute(builder: (_) => SearchByTopic());
      case RouteNames.favoriteScreen:
        return MaterialPageRoute(builder: (_) => FavoritesScreen());
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
