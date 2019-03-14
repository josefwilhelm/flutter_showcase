// To parse this JSON data, do
//
//     final predictions = predictionsFromJson(jsonString);

import 'dart:convert';

Predictions predictionsFromJson(String str) {
  final jsonData = json.decode(str);
  return Predictions.fromJson(jsonData);
}

String predictionsToJson(Predictions data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Predictions {
  List<Prediction> predictions;

  Predictions({
    this.predictions,
  });

  factory Predictions.fromJson(Map<String, dynamic> json) => new Predictions(
        predictions: new List<Prediction>.from(
            json["predictions"].map((x) => Prediction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "predictions":
            new List<dynamic>.from(predictions.map((x) => x.toJson())),
      };
}

class Prediction {
  String description;
  List<Term> terms;

  Prediction({
    this.description,
    this.terms,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => new Prediction(
        description: json["description"],
        terms: new List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "terms": new List<dynamic>.from(terms.map((x) => x.toJson())),
      };
}

class Term {
  int offset;
  String value;

  Term({
    this.offset,
    this.value,
  });

  factory Term.fromJson(Map<String, dynamic> json) => new Term(
        offset: json["offset"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "value": value,
      };
}
