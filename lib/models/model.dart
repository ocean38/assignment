class CardModel {
  CardModel({required this.lanes});

  final List<ListModel> lanes;

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      lanes: json["lanes"] == null
          ? []
          : List<ListModel>.from(
              json["lanes"]!.map((x) => ListModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "lanes": lanes.map((x) => x.toJson()).toList(),
      };
}

class ListModel {
  ListModel({
    required this.cards,
    required this.title,
  });

  final List<CardDetailsModel> cards;

  String? title;

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      cards: json["cards"] == null
          ? []
          : List<CardDetailsModel>.from(
              json["cards"]!.map((x) => CardDetailsModel.fromJson(x))),
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "cards": cards.map((x) => x.toJson()).toList(),
        "title": title,
      };
}

class CardDetailsModel {
  CardDetailsModel({
    required this.description,
    required this.title,
    createdDate,
  }) : createdDate = DateTime.now();

  final DateTime? createdDate;
  String? description;
  String? title;

  factory CardDetailsModel.fromJson(Map<String, dynamic> json) {
    return CardDetailsModel(
        description: json["description"],
        title: json["title"],
        createdDate: json['createdDate']);
  }

  Map<String, dynamic> toJson() => {"description": description, "title": title};
}
