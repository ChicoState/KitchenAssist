import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitchen_assist/authprovider.dart';
import 'package:kitchen_assist/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitchen_assist/Pages/RecipePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    String id;
    List<String> foods = new List();
    final db = Firestore.instance;
    final _formKey = GlobalKey<FormState>();
    String name;

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

    Card buildItem(DocumentSnapshot doc) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${doc.data["Food"]}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: 4),
                  FlatButton(
                    onPressed: () => deleteData(doc),
                    child: Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

  @override
    TextFormField buildTextFormField() {
      return TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter item',
          fillColor: Colors.grey[300],
          filled: true,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
        onSaved: (value) => name = value,
      );
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Form(
              key: _formKey,
              child: buildTextFormField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    createData();
                    foods.add(_controller.value.text);
                    _controller.clear();
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white)),
                  color: Colors.green,

                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: db.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
                } else {
                  return SizedBox();
                }
              },
            )
          ],
        ),
      );
    }


    void createData() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        db.collection('users').document(user.uid).updateData({
          "items": FieldValue.arrayUnion(foods)});
        }
    }

    void readData() async {
      DocumentSnapshot snapshot = await db.collection('users').document(id).get();
      print(snapshot.data['FoodName']);
    }

    void deleteData(DocumentSnapshot doc) async {
      await db.collection('users').document(doc.documentID).delete();
      setState(() => id = null);
    }



//  Widget enterFoodItem() {
//    return Row(
//      mainAxisSize: MainAxisSize.min,
//      children: <Widget>[
//        Flexible(
//          child: TextField(
//            controller: _controller,
//            autofocus: false,
//            textCapitalization: TextCapitalization.sentences,
//            decoration: new InputDecoration(
//              fillColor: Colors.white,
//                border: new OutlineInputBorder(
//                  borderRadius: new BorderRadius.circular(15.0),
//                  borderSide: new BorderSide(),
//                ),
//                hintText: 'Enter ingredient...',
//                contentPadding: const EdgeInsets.all(15.0)),
//          ),
//        ),
//        Container(
//          margin: const EdgeInsets.only(left: 15.0),
//          child: RaisedButton(
//            onPressed: () {
//              _addFoodItem(_controller.value.text);
//              _controller.clear();
//              //Firestore.instance.collection('users').document(user.uid).setData({
//
//            //  });
//            },
//            child: Text('uahdalkj'),
//            color: Colors.tealAccent,
//           ),
//        )
//      ],
//    );
//  }

  void _addFoodItem(String item) {
    if (item.length > 0) {
      setState(() => _foodItems.add(item));
    }
  }


//  Widget buildFoodList() {
//    return Flexible(
//      child: ListView.builder(
//        itemBuilder: (context, index) {
//          if (index < _foodItems.length) {
//            return buildFoodItem(_foodItems[index]);
//          }
//        },
//      ),
//    );
//  }

  Widget buildFoodItem(BuildContext context,String item) {
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

//  void _pushItemFoodScreen() {
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return new Scaffold(
//          appBar: new AppBar(
//            title: new Text('Add a new item'),
//            backgroundColor: new Color(0x673AB7),
//          ),
//          body: new TextField(
//            autofocus: true,
//            onSubmitted: (val) {
//              _addFoodItem(val);
//              Navigator.pop(context);
//            },
//            decoration: new InputDecoration(
//                hintText: 'Enter a food item...',
//                contentPadding: const EdgeInsets.all(16.0)),
//          ),
//          backgroundColor: Colors.lightBlue[100]);
//    }));
//  }


  }