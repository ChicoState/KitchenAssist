import 'dart:async';
import 'dart:convert';
import 'package:kitchen_assist/Pages/Recipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

// Uncomment this to connect the api
/*Future<Recipe> fetchPost() async {
  final response =
  await http.get("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex?includeIngredients=beef%2C+onions%2C+lettuce&ranking=1&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&limitLicense=false&offset=0&number=3",
      headers: {"X-RapidAPI-Key": "5cdbcc2fb2msha7c9f188f095aa2p14cf70jsn62c2255d3972"});
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    //debugPrint("loading fine");
    //debugPrint(response.body);
    print("Number of requests left: " + response.headers["x-ratelimit-requests-remaining"]);
    print("Number of results left: " + response.headers["x-ratelimit-results-remaining"]);
    final recipe = recipeFromJson(response.body);
    return recipe;
  } else {
    debugPrint("error loading");
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}*/

// Comment this out when you connect the api
// This uses a local file to get the recipes so we don't go over the request limit
// for the api
Future<Recipe> fetchPost() async {
  final response = await rootBundle.loadString('assets/complexSearch.json');
  final recipe = recipeFromJson(response);
  return recipe;
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the id and title
  final List<AnalyzedInstruction> instructions;
  final String name;

  // In the constructor, require a recipe
  DetailScreen({Key key, @required this.instructions, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Center(
          child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              padding: EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int index) {
                return new Text(instructions[0].steps[index].number.toString()+ ") " + instructions[0].steps[index].step,
                    style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                );
              },
              itemCount: instructions[0].steps.length
          ),
        )
    );
  }
}

class recipePage extends StatelessWidget{
  final Future<Recipe> post;

  recipePage({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Recipe>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(10.0),
                itemBuilder: (BuildContext context, int index) {
                  //return new Card(
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          //TitleID temp
                          builder: (context) => DetailScreen(instructions: snapshot.data.results[index].analyzedInstructions, name: snapshot.data.results[index].title),
                        ),
                      );
                    },
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(snapshot.data.results[index].title,
                            style: new TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Image.network(snapshot.data.results[index].image)
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data == null ? 0 : snapshot.data.number,
              );
            } else if (snapshot.hasError) {
              debugPrint('errors');
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}