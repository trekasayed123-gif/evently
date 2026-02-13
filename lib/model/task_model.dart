import 'dart:core';

class TaskModel {
  String title;
  String description;
  int date;
  String id;
  String category;
  bool isFavorite = false;
  String userId="";





  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    this.id = "",
    required this.category,
    this.isFavorite = false,
    this.userId="",

  });
  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json["title"] ?? "No Title",
      description: json["description"] ?? "",
      date: json["date"] ?? DateTime.now().millisecondsSinceEpoch,
      id: json["id"] ?? "",
      category: json["category"] ?? "All",
      isFavorite: json["isFavorite"] ?? false,
      userId: json["userId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "id": id,
      "category": category,
      "isFavorite": isFavorite,
      "userId": userId,

    };
  }

}
