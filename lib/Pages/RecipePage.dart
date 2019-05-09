import 'dart:async';
import 'dart:convert';
import 'package:kitchen_assist/Pages/Recipe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

// Uncomment this to connect the api
/*Future<Recipe> fetchPost(List<String> ingredients) async {

  String request = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex?includeIngredients=";
  if (ingredients.length > 0) {
    request += ingredients[0];
  }
  for (int i = 1; i < ingredients.length; i++) {
    request += "%2C+" + ingredients[i];
  }
  request += "&ranking=1&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&limitLicense=false&offset=0&number=5";

  final response =
  //await http.get("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/searchComplex?includeIngredients=beef%2C+onions%2C+lettuce&ranking=1&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&limitLicense=false&offset=0&number=3",
  await http.get(request,
      headers: {"X-RapidAPI-Key": "5cdbcc2fb2msha7c9f188f095aa2p14cf70jsn62c2255d3972"});

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
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
Future<Recipe> fetchPost(List<String> ingredients) async {
  final response = await rootBundle.loadString('assets/complexSearch.json');
  final recipe = recipeFromJson(response);
  return recipe;
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the id and title
  final Result recipe;

  // In the constructor, require a recipe
  DetailScreen({Key key, @required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.title, style: TextStyle(color: Colors.black),),
          backgroundColor: new Color(0xFF64FFDA),
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 10),
                    child: Column(
                      children: [
                        Icon(Icons.kitchen, color: Colors.green[500]),
                        Text('PREP:'),
                        Text(recipe.preparationMinutes.toString() + " min"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 10),
                    child: Column(
                      children: [
                        Icon(Icons.timer, color: Colors.green[500]),
                        Text('COOK:'),
                        Text(recipe.cookingMinutes.toString() + " min"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 10),
                    child: Column(
                      children: [
                          Icon(Icons.restaurant, color: Colors.green[500]),
                          Text('SERVINGS:'),
                          Text(recipe.servings.toString()),
                      ],
                    ),
                  ),
                ]
            ),
            new Divider(
              color: Colors.black54,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 5),
              child: new Text("Directions:",
                style: new TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                )
              ),
            ),
            new Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(16.0),
                itemBuilder: (BuildContext context, int index) {
                  return new Text(recipe.analyzedInstructions[0].steps[index].number.toString()+ ") " + recipe.analyzedInstructions[0].steps[index].step,
                      style: new TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )
                  );
                },
                itemCount: recipe.analyzedInstructions[0].steps.length
              ),
            ),
          ],
        ),
    );
  }
}

class recipePage extends StatelessWidget{
  final Future<Recipe> post;
  final List<String> ingredients = ['beef', 'onions', 'lettuce'];

  recipePage({Key key, this.post/*, @required this.ingredients*/}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Recipe>(
          future: fetchPost(ingredients),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(10.0),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(recipe: snapshot.data.results[index]),
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
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("Rating: " + snapshot.data.results[index].spoonacularScore.toString()),
                              new Text("Ready in " + snapshot.data.results[index].readyInMinutes.toString() + " minutes."),
                            ]
                        ),
                        Image.network(snapshot.data.results[index].image)
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data == null ? 0 : snapshot.data.number,
              );
            } else if (snapshot.hasError) {
              debugPrint('errors in RecipePage');
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
