import 'package:bloc/bloc.dart';
import 'package:floom/account/floom_account.dart';
import 'package:floom/home_page.dart';
import 'package:floom/login/authentication_bloc/bloc.dart';
import 'package:floom/login/user.dart';
import 'package:floom/model/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'route_gen.dart';
import 'floom_cart.dart';
import 'bloc_delegate.dart';

void main() {
  final User user = User();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(
    bloc: AuthenticationBloc(user: user)..dispatch(AppStarted()),
    child: MyApp(user: user),
  ));
}

class MyApp extends StatelessWidget {
  final User _user;

  MyApp({Key key, @required User user})
      : assert(user != null),
        _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPage(user: _user),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
          primaryColor: Colors.white,
          hintColor: Color.fromARGB(255, 250, 82, 32),
          accentColor: Color.fromARGB(255, 250, 82, 32)),
    );
  }
}

class MenuPage extends StatefulWidget {
  final User _user;
  MenuPage({Key key, @required User user})
      : assert(user != null),
        _user = user,
        super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;
  var itemList;
  bool isSearching = false;
  String searchText = "";
  final TextEditingController _searchQuery = new TextEditingController();
  Icon _actionIcon = new Icon(
    Icons.search,
    color: Color.fromARGB(255, 250, 82, 32),
  );
  Widget appBarTitle = Text(
    "Floom",
    style: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 250, 82, 32)),
  );

  _MenuPageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          isSearching = false;
          searchText = "";
        });
      } else {
        setState(() {
          isSearching = true;
          searchText = _searchQuery.text;
        });
      }
    });
  }

  Widget _buildBody({int selectedTab}) {
    switch (selectedTab) {
      case 0:
        return new HomePage(callback: callback, updateTab: _updateTab);
      case 1:
        return new CartPage();
      case 2:
        return new AccountPage(
          user: widget._user,
        );
    }
    return Container();
  }

  _updateTab(int index) {
    if (index != null) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  callback(itemList2) {
    setState(() {
      itemList = itemList2['category'];
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildList() {
    if (searchText.isNotEmpty) {
      List _searchList = List();
      for (int i = 0; i < itemList.length; i++) {
        for (int j = 0; j < itemList[i]['items'].length; j++) {
          String name = itemList[i]['items'][j]['name'];
          if (name.toLowerCase().contains(searchText.toLowerCase())) {
            _searchList.add(itemList[i]['items'][j]);
          }
        }
      }
      return GridView.builder(
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _searchList.length,
        itemBuilder: (context, index) {
          // map JSON to item object
          Item item = Item.fromJSON(_searchList[index]);

          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/item', arguments: item);
            },
            child: new Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                elevation: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 145,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        child: CachedNetworkImage(
                          placeholder: (context, string) =>
                              CircularProgressIndicator(),
                          imageUrl: item.imageurl,
                          fit: BoxFit.cover,
                          repeat: ImageRepeat.repeatX,
                        ),
                      ),
                    ),
                    new Text(item.name,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300)),
                    new Text("\$" + item.price.toString(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300))
                  ],
                )),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget _buildAppBar(BuildContext context) {
    return new AppBar(
      title: this.appBarTitle,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: _actionIcon,
          onPressed: () {
            setState(() {
              if (this._actionIcon.icon == Icons.search) {
                // when search is initiated
                this._actionIcon = new Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 250, 82, 32),
                );
                this.appBarTitle = AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 10000),
                    curve: Curves.easeInExpo,
                    child: TextField(
                      autofocus: true,
                      controller: _searchQuery,
                      cursorColor: Color.fromARGB(255, 250, 82, 32),
                      style: new TextStyle(
                        color: Color.fromARGB(255, 250, 82, 32),
                      ),
                      decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search,
                              color: Color.fromARGB(255, 250, 82, 32)),
                          hintText: "Search...",
                          hintStyle: new TextStyle(
                              color: Color.fromARGB(255, 250, 82, 32)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 250, 82, 32)))),
                    ));
              } else {
                // when X is pressed -> go back to normal
                this._actionIcon = new Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 250, 82, 32),
                );
                this.appBarTitle = Text(
                  "Floom",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 250, 82, 32)),
                );
                isSearching = false;
                _searchQuery.clear();
              }
            });
          },
        ),
      ],
      backgroundColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (BuildContext context, AuthenticationState state) {
        if (state is Uninitialized) {
          Navigator.pushNamed(context, '/splash');
        }
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', ModalRoute.withName('/'),
              arguments: widget._user);
        }
        if (state is Authenticated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: isSearching
            ? _buildList()
            : _buildBody(selectedTab: _selectedIndex),
        bottomNavigationBar: new BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Cart'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Account'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:
              Color.fromARGB(255, 250, 82, 32), // SELECTED ITEM COLOR
          unselectedItemColor: Color.fromARGB(130, 250, 82, 32),
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
