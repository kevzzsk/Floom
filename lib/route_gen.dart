import 'package:flutter/material.dart';
import 'main.dart';
import 'floom_item.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=> MenuPage());
      case '/item':
        return MaterialPageRoute(builder: (context)=> ItemPage(data:args));
      
      default: // display error route
        return _errorRoute();
    }
  }
}


Route<dynamic> _errorRoute(){
  return MaterialPageRoute(builder: (context)=> Scaffold( body: Center(child: Text('ERROR ROUTE!'),),));
}