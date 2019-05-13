import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListPage extends StatefulWidget {
  const ListPage({this.onSignedOut});
  final VoidCallback onSignedOut;


  @override
  createState() => new ListPageState();
}
class ListPageState extends State<ListPage>{
  String id;
  List<String> foods = [];
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;

  TextEditingController _controller = new TextEditingController();

  @override
  Widget buildTextFormField() {
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
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Form(
                  key: _formKey,
                  child: buildTextFormField(),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  createData();
                  _addFoodItem(_controller.value.text);
                  _controller.clear();
                },
                child: Text('Save', style: TextStyle(color: Colors.white)),
                color: Colors.green,
              ),
            ],
          ),
        Expanded(
        child: ListView(
            shrinkWrap: true,
            children: <Widget>[
               buildFoodList(),
            ],
            ),
        ),
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
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await db.collection('users').document(user.uid).get();
    print(snapshot.data['FoodName']);
  }

  void deleteData(DocumentSnapshot doc) async {
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //await db.collection('users').document(user.uid).updateData(
        //FieldValueType.arrayUnion)
    setState(() => id = null);
  }


  void _addFoodItem(String item){
    if(item.length > 0){
      setState(() {
        foods.add(item);
      });
    }
  }


  Widget buildFoodList(){
    return Container(
      child:ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index){
          if(index < foods.length) {
            return buildFoodItem(foods[index]);
          }
        },
      ),
    );
  }

  Widget buildFoodItem(String item) {
    return new ListTile(
      title: new Text(item),
      trailing: FlatButton(
        onPressed: () {
          setState(() {
            foods.remove(item);
          });
        },
        child: Icon(Icons.clear),
      ),
    );
  }

}
