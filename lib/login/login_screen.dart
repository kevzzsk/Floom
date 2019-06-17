import 'package:floom/login/login_form.dart';
import 'package:floom/login/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc/bloc.dart';


class LoginScreen extends StatelessWidget {
  final User _user;
  
  LoginScreen({Key key, @required User user})
      : assert(user != null),
        _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'),centerTitle: true,automaticallyImplyLeading: false,),
      body: BlocProvider<LoginBloc>(
        bloc: LoginBloc(user: _user),
        child: LoginForm(user: _user)
      ),
    );
  }
}