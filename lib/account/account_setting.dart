import 'package:cached_network_image/cached_network_image.dart';
import 'package:floom/login/authentication_bloc/bloc.dart';
import 'package:floom/login/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AccountSettings extends StatelessWidget {
final User _user;

  AccountSettings({Key key, User user})
      : _user = user,
        super(key: key);

  Widget _buildMid() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              debugPrint("Username Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Username",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(_user.isSignedIn() != null
                      ? _user.email
                      : "Guest")
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 0.5,
        ),
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              debugPrint("Change Password Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBot() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              debugPrint("Phone Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Phone",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 0.5,
        ),
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              debugPrint("Email Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Email",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showProgress(context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Stack(children: [
              Opacity(
                  opacity: 0.7,
                  child: Container(
                    color: Colors.grey[100],
                  )),
              Center(
                child: CircularProgressIndicator(),
              )
            ]));
    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: 1));

    overlayEntry.remove();
  }

  Widget _signOutButton(BuildContext context) {
    return RaisedButton(
      child: Text('Sign Out'),
      onPressed: () {
        //signout
        _showProgress(context);
        BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedOut());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text('Account Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.1,
                  0.5,
                  0.7,
                  0.9
                ],
                    colors: [
                  Colors.deepOrange[800],
                  Colors.deepOrange[600],
                  Colors.deepOrange,
                  Colors.deepOrange[400],
                ])),
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
              imageUrl:
                  "https://amp.businessinsider.com/images/5d003e806fc920431956da32-1920-960.jpg",
              placeholder: (context, string) => CircleAvatar(
                    child: Text('AR'),
                  ),
            ),
          ),
          _buildMid(),
          SizedBox(
            height: 20,
          ),
          _buildBot(),
          SizedBox(height: 10),
          _signOutButton(context)
        ],
      ),
    );
  }
}
