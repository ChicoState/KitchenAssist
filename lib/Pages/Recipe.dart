import 'dart:convert';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

class Recipe {
  List<Result> results;
  String baseUri;
  int offset;
  int number;
  int totalResults;
  int processingTimeMs;

  Recipe({
    this.results,
    this.baseUri,
    this.offset,
    this.number,
    this.totalResults,
    this.processingTimeMs,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => new Recipe(
    results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    baseUri: json["baseUri"],
    offset: json["offset"],
    number: json["number"],
    totalResults: json["totalResults"],
    processingTimeMs: json["processingTimeMs"],
  );

  Map<String, dynamic> toJson() => {
    "results": new List<dynamic>.from(results.map((x) => x.toJson())),
    "baseUri": baseUri,
    "offset": offset,
    "number": number,
    "totalResults": totalResults,
    "processingTimeMs": processingTimeMs,
  };
}

class Result {
  bool vegetarian;
  bool vegan;
  bool glutenFree;
  bool dairyFree;
  bool veryHealthy;
  bool cheap;
  bool veryPopular;
  bool sustainable;
  int weightWatcherSmartPoints;
  Gaps gaps;
  bool lowFodmap;
  bool ketogenic;
  bool whole30;
  int preparationMinutes;
  int cookingMinutes;
  String sourceUrl;
  String spoonacularSourceUrl;
  int aggregateLikes;
  int spoonacularScore;
  int healthScore;
  String creditText;
  String sourceName;
  double pricePerServing;
  int id;
  String title;
  int readyInMinutes;
  int servings;
  String image;
  ImageType imageType;
  List<String> cuisines;
  List<String> dishTypes;
  List<String> diets;
  List<dynamic> occasions;
  WinePairing winePairing;
  List<AnalyzedInstruction> analyzedInstructions;
  String creditsText;
  int usedIngredientCount;
  int missedIngredientCount;
  int likes;
  List<SedIngredient> missedIngredients;
  List<SedIngredient> usedIngredients;
  List<SedIngredient> unusedIngredients;

  Result({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.lowFodmap,
    this.ketogenic,
    this.whole30,
    this.preparationMinutes,
    this.cookingMinutes,
    this.sourceUrl,
    this.spoonacularSourceUrl,
    this.aggregateLikes,
    this.spoonacularScore,
    this.healthScore,
    this.creditText,
    this.sourceName,
    this.pricePerServing,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.image,
    this.imageType,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.winePairing,
    this.analyzedInstructions,
    this.creditsText,
    this.usedIngredientCount,
    this.missedIngredientCount,
    this.likes,
    this.missedIngredients,
    this.usedIngredients,
    this.unusedIngredients,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    vegetarian: json["vegetarian"],
    vegan: json["vegan"],
    glutenFree: json["glutenFree"],
    dairyFree: json["dairyFree"],
    veryHealthy: json["veryHealthy"],
    cheap: json["cheap"],
    veryPopular: json["veryPopular"],
    sustainable: json["sustainable"],
    weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
    gaps: gapsValues.map[json["gaps"]],
    lowFodmap: json["lowFodmap"],
    ketogenic: json["ketogenic"],
    whole30: json["whole30"],
    preparationMinutes: json["preparationMinutes"] == null ? null : json["preparationMinutes"],
    cookingMinutes: json["cookingMinutes"] == null ? null : json["cookingMinutes"],
    sourceUrl: json["sourceUrl"],
    spoonacularSourceUrl: json["spoonacularSourceUrl"],
    aggregateLikes: json["aggregateLikes"],
    spoonacularScore: json["spoonacularScore"],
    healthScore: json["healthScore"],
    creditText: json["creditText"] == null ? null : json["creditText"],
    sourceName: json["sourceName"] == null ? null : json["sourceName"],
    pricePerServing: json["pricePerServing"].toDouble(),
    id: json["id"],
    title: json["title"],
    readyInMinutes: json["readyInMinutes"],
    servings: json["servings"],
    image: json["image"],
    imageType: imageTypeValues.map[json["imageType"]],
    cuisines: new List<String>.from(json["cuisines"].map((x) => x)),
    dishTypes: new List<String>.from(json["dishTypes"].map((x) => x)),
    diets: new List<String>.from(json["diets"].map((x) => x)),
    occasions: new List<dynamic>.from(json["occasions"].map((x) => x)),
    winePairing: WinePairing.fromJson(json["winePairing"]),
    analyzedInstructions: new List<AnalyzedInstruction>.from(json["analyzedInstructions"].map((x) => AnalyzedInstruction.fromJson(x))),
    creditsText: json["creditsText"] == null ? null : json["creditsText"],
    usedIngredientCount: json["usedIngredientCount"],
    missedIngredientCount: json["missedIngredientCount"],
    likes: json["likes"],
    missedIngredients: new List<SedIngredient>.from(json["missedIngredients"].map((x) => SedIngredient.fromJson(x))),
    usedIngredients: new List<SedIngredient>.from(json["usedIngredients"].map((x) => SedIngredient.fromJson(x))),
    unusedIngredients: new List<SedIngredient>.from(json["unusedIngredients"].map((x) => SedIngredient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "vegetarian": vegetarian,
    "vegan": vegan,
    "glutenFree": glutenFree,
    "dairyFree": dairyFree,
    "veryHealthy": veryHealthy,
    "cheap": cheap,
    "veryPopular": veryPopular,
    "sustainable": sustainable,
    "weightWatcherSmartPoints": weightWatcherSmartPoints,
    "gaps": gapsValues.reverse[gaps],
    "lowFodmap": lowFodmap,
    "ketogenic": ketogenic,
    "whole30": whole30,
    "preparationMinutes": preparationMinutes == null ? null : preparationMinutes,
    "cookingMinutes": cookingMinutes == null ? null : cookingMinutes,
    "sourceUrl": sourceUrl,
    "spoonacularSourceUrl": spoonacularSourceUrl,
    "aggregateLikes": aggregateLikes,
    "spoonacularScore": spoonacularScore,
    "healthScore": healthScore,
    "creditText": creditText == null ? null : creditText,
    "sourceName": sourceName == null ? null : sourceName,
    "pricePerServing": pricePerServing,
    "id": id,
    "title": title,
    "readyInMinutes": readyInMinutes,
    "servings": servings,
    "image": image,
    "imageType": imageTypeValues.reverse[imageType],
    "cuisines": new List<dynamic>.from(cuisines.map((x) => x)),
    "dishTypes": new List<dynamic>.from(dishTypes.map((x) => x)),
    "diets": new List<dynamic>.from(diets.map((x) => x)),
    "occasions": new List<dynamic>.from(occasions.map((x) => x)),
    "winePairing": winePairing.toJson(),
    "analyzedInstructions": new List<dynamic>.from(analyzedInstructions.map((x) => x.toJson())),
    "creditsText": creditsText == null ? null : creditsText,
    "usedIngredientCount": usedIngredientCount,
    "missedIngredientCount": missedIngredientCount,
    "likes": likes,
    "missedIngredients": new List<dynamic>.from(missedIngredients.map((x) => x.toJson())),
    "usedIngredients": new List<dynamic>.from(usedIngredients.map((x) => x.toJson())),
    "unusedIngredients": new List<dynamic>.from(unusedIngredients.map((x) => x.toJson())),
  };
}

class AnalyzedInstruction {
  String name;
  List<Step> steps;

  AnalyzedInstruction({
    this.name,
    this.steps,
  });

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) => new AnalyzedInstruction(
    name: json["name"],
    steps: new List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "steps": new List<dynamic>.from(steps.map((x) => x.toJson())),
  };
}

class Step {
  int number;
  String step;
  List<Ent> ingredients;
  List<Ent> equipment;
  Length length;

  Step({
    this.number,
    this.step,
    this.ingredients,
    this.equipment,
    this.length,
  });

  factory Step.fromJson(Map<String, dynamic> json) => new Step(
    number: json["number"],
    step: json["step"],
    ingredients: new List<Ent>.from(json["ingredients"].map((x) => Ent.fromJson(x))),
    equipment: new List<Ent>.from(json["equipment"].map((x) => Ent.fromJson(x))),
    length: json["length"] == null ? null : Length.fromJson(json["length"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "step": step,
    "ingredients": new List<dynamic>.from(ingredients.map((x) => x.toJson())),
    "equipment": new List<dynamic>.from(equipment.map((x) => x.toJson())),
    "length": length == null ? null : length.toJson(),
  };
}

class Ent {
  int id;
  String name;
  String image;

  Ent({
    this.id,
    this.name,
    this.image,
  });

  factory Ent.fromJson(Map<String, dynamic> json) => new Ent(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class Length {
  int number;
  Unit unit;

  Length({
    this.number,
    this.unit,
  });

  factory Length.fromJson(Map<String, dynamic> json) => new Length(
    number: json["number"],
    unit: unitValues.map[json["unit"]],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "unit": unitValues.reverse[unit],
  };
}

enum Unit { MINUTES }

final unitValues = new EnumValues({
  "minutes": Unit.MINUTES
});

enum Gaps { NO }

final gapsValues = new EnumValues({
  "no": Gaps.NO
});

enum ImageType { JPG, JPEG }

final imageTypeValues = new EnumValues({
  "jpeg": ImageType.JPEG,
  "jpg": ImageType.JPG
});

class SedIngredient {
  int id;
  double amount;
  String unit;
  String unitLong;
  String unitShort;
  String aisle;
  String name;
  String original;
  String originalString;
  String originalName;
  List<String> metaInformation;
  String image;
  String extendedName;

  SedIngredient({
    this.id,
    this.amount,
    this.unit,
    this.unitLong,
    this.unitShort,
    this.aisle,
    this.name,
    this.original,
    this.originalString,
    this.originalName,
    this.metaInformation,
    this.image,
    this.extendedName,
  });

  factory SedIngredient.fromJson(Map<String, dynamic> json) => new SedIngredient(
    id: json["id"],
    amount: json["amount"].toDouble(),
    unit: json["unit"],
    unitLong: json["unitLong"],
    unitShort: json["unitShort"],
    aisle: json["aisle"],
    name: json["name"],
    original: json["original"],
    originalString: json["originalString"],
    originalName: json["originalName"],
    metaInformation: new List<String>.from(json["metaInformation"].map((x) => x)),
    image: json["image"],
    extendedName: json["extendedName"] == null ? null : json["extendedName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "unit": unit,
    "unitLong": unitLong,
    "unitShort": unitShort,
    "aisle": aisle,
    "name": name,
    "original": original,
    "originalString": originalString,
    "originalName": originalName,
    "metaInformation": new List<dynamic>.from(metaInformation.map((x) => x)),
    "image": image,
    "extendedName": extendedName == null ? null : extendedName,
  };
}

class WinePairing {
  List<String> pairedWines;
  String pairingText;
  List<ProductMatch> productMatches;

  WinePairing({
    this.pairedWines,
    this.pairingText,
    this.productMatches,
  });

  factory WinePairing.fromJson(Map<String, dynamic> json) => new WinePairing(
    pairedWines: json["pairedWines"] == null ? null : new List<String>.from(json["pairedWines"].map((x) => x)),
    pairingText: json["pairingText"] == null ? null : json["pairingText"],
    productMatches: json["productMatches"] == null ? null : new List<ProductMatch>.from(json["productMatches"].map((x) => ProductMatch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pairedWines": pairedWines == null ? null : new List<dynamic>.from(pairedWines.map((x) => x)),
    "pairingText": pairingText == null ? null : pairingText,
    "productMatches": productMatches == null ? null : new List<dynamic>.from(productMatches.map((x) => x.toJson())),
  };
}

class ProductMatch {
  int id;
  String title;
  String description;
  String price;
  String imageUrl;
  double averageRating;
  int ratingCount;
  double score;
  String link;

  ProductMatch({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.averageRating,
    this.ratingCount,
    this.score,
    this.link,
  });

  factory ProductMatch.fromJson(Map<String, dynamic> json) => new ProductMatch(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    averageRating: json["averageRating"].toDouble(),
    ratingCount: json["ratingCount"],
    score: json["score"].toDouble(),
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "averageRating": averageRating,
    "ratingCount": ratingCount,
    "score": score,
    "link": link,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}