import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kitchen_assist/Pages/RecipePage.dart';
import 'package:kitchen_assist/Pages/ListPage.dart';
import 'package:kitchen_assist/authprovider.dart';
import 'package:kitchen_assist/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  /*This Widget contains the text form to enter in a new food item to the list*/
  int currentTab = 0;
  ListPage page1;
  recipePage page2;
  List<Widget> pages;
  Widget currentPage;

  BaseAuth auth;
  Future<void> _signOut(BuildContext context) async {

    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override

  void initState(){
    page1 = ListPage();
    page2 = recipePage();

    pages = [page1, page2];
    currentPage = page1;
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          )
        ],
        iconTheme: Theme.of(context).accentIconTheme,
        title: new Text('In-House Food'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap:(int index){
            setState(() {
              currentTab = index;
              currentPage = pages[index];
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              title: Text("Recipes"),
            ),
          ]
      ),
    );
  }
}