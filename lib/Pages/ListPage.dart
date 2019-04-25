import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitchen_assist/authprovider.dart';
import 'package:kitchen_assist/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_assist/Pages/RecipePage.dart';

class ListPage extends StatefulWidget {
  const ListPage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  createState() => new ListPageState();
}
  class ListPageState extends State<ListPage>{
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


  List<String> _foodItems = [];
  TextEditingController _controller = new TextEditingController();
  @override

  void initState(){
    page1 = ListPage();
    page2 = recipePage(post: fetchPost());
    pages = [page1, page2];
    currentPage = page1;
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column( //maybe make new class
          children: <Widget>[
            enterFoodItem(),
            buildFoodList(),
          ]
      ),
    );
  }




  Widget enterFoodItem() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: TextField(
            controller: _controller,
            autofocus: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: new InputDecoration(
                fillColor: Theme
                    .of(context)
                    .dialogBackgroundColor,
                hintStyle: TextStyle(color: Theme
                    .of(context)
                    .hintColor),
                hintText: 'Enter a food item...',
                contentPadding: const EdgeInsets.all(16.0)),
          ),
        ),
        RaisedButton(
          onPressed: () {
            Firestore.instance
                    .collection('Test')
                    .document('5cK2LdvVfgmgM7EGQb6m')//user id
                    .updateData({
                  'data': _controller.value.text,
                });
            _addFoodItem(_controller.value.text);
            _controller.clear();
          },
          child: Text('Submit'),
          color: Theme
              .of(context)
              .buttonColor,
        ),
      ],
    );
  }

  void _addFoodItem(String item) {
    if (item.length > 0) {
      setState(() => _foodItems.add(item));
    }
  }


  Widget buildFoodList() {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index < _foodItems.length) {
            return buildFoodItem(_foodItems[index]);
          }
        },
      ),
    );
  }

  Widget buildFoodItem(String item) {
    return ListTile(
      title: new Text(item),
      trailing: FlatButton(
        onPressed: () {
          setState(() {
            _foodItems.remove(item);
          });
        },
        child: Icon(Icons.clear),
      ),
    );
  }

  void _pushItemFoodScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new item'),
            backgroundColor: new Color(0x673AB7),
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addFoodItem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
                hintText: 'Enter a food item...',
                contentPadding: const EdgeInsets.all(16.0)),
          ),
          backgroundColor: Colors.lightBlue[100]);
    }));
  }
//  void _firestoreTest() {
//    TextEditingController _controller = new TextEditingController();
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text('Firestore'),
//          backgroundColor: Theme
//              .of(context)
//              .bottomAppBarColor,
//        ),
//        body: Column(
//          children: <Widget>[
//            TextField(
//              controller: _controller,
//              autofocus: true,
//              textCapitalization: TextCapitalization.sentences,
//            ),
//            RaisedButton(
//              padding: EdgeInsets.all(1.0),
//              child: Text('Submit'),
//              color: Theme
//                  .of(context)
//                  .buttonColor,
//              onPressed: () {
//                Firestore.instance
//                    .collection('Test')
//                    .document('5cK2LdvVfgmgM7EGQb6m')
//                    .updateData({
//                  'data': _controller.value.text,
//                });
//                _controller.clear();
//              },
//            ),
//            StreamBuilder(
//              stream: Firestore.instance.collection('Test').snapshots(),
//              builder: (context, snapshot) {
//                if (!snapshot.hasData) return const Text('Waiting...');
//                return Text(snapshot.data.documents[0]['data']);
//              },
//            ),
//          ],
//        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {
//            Navigator.pop(context);
//          },
//          child: Icon(Icons.clear),
//        ),
//      );
//    }));
//  }
  }