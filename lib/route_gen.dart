import 'package:floom/login/login_screen.dart';
import 'package:floom/login/splash_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'floom_item.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=> MenuPage(user:args));
      case '/item':
        return MaterialPageRoute(builder: (context)=> ItemPage(data:args));
      case '/login':
        return MaterialPageRoute(builder: (context)=> LoginScreen(user: args));
      case '/splash':
        return MaterialPageRoute(builder: (context)=> SplashScreen());
      
      default: // display error route
        return _errorRoute();
    }
  }
}


Route<dynamic> _errorRoute(){
  return MaterialPageRoute(builder: (context)=> Scaffold( body: Center(child: Text('ERROR ROUTE!'),),));
}