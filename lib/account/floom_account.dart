import 'package:cached_network_image/cached_network_image.dart';
import 'package:floom/login/user.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final User _user;

  AccountPage({User user}) : _user = user;

  Widget _buildTop() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  "https://amp.businessinsider.com/images/5d003e806fc920431956da32-1920-960.jpg",
              placeholder: (context, string) => CircleAvatar(
                    child: Text('AR'),
                  ),
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Admin',
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),
                ),
                SizedBox(height: 12,),
                Text('Following 42'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMid() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              debugPrint("Wallet Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_balance_wallet),
                  SizedBox(width: 7,),
                  Expanded(child: Text("Wallet",style: TextStyle(fontSize: 16),),)
                ],
              ),
            ),
          ),
        ),
        Divider(height: 0.5,),
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              debugPrint("My Likes Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.favorite),
                  SizedBox(width: 7,),
                  Expanded(child: Text("My Likes",style: TextStyle(fontSize: 16),),)
                ],
              ),
            ),
          ),
        ),
        Divider(height: 0.5,),
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              debugPrint("My Voucher Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.call_to_action),
                  SizedBox(width: 7,),
                  Expanded(child: Text("My Voucher",style: TextStyle(fontSize: 16),),)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBot(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              debugPrint("Account Setting Clicked");
              Navigator.pushNamed(context, '/accountsetting',arguments: _user);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle),
                  SizedBox(width: 7,),
                  Expanded(child: Text("Account Settings",style: TextStyle(fontSize: 16),),)
                ],
              ),
            ),
          ),
        ),
        Divider(height: 0.5,),
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: (){
              debugPrint("Help Center Clicked");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.help_outline),
                  SizedBox(width: 7,),
                  Expanded(child: Text("Help Center",style: TextStyle(fontSize: 16),),)
                ],
              ),
            ),
          ),
        ),
      ],
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          _buildTop(),
          SizedBox(height: 20,),
          _buildMid(),
          SizedBox(height: 20,),
          _buildBot(context),
        ],
      ),
    );
  }
}
