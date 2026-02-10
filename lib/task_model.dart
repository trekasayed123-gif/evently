import 'dart:core';

class TaskModel {
  String title;
  String description;
  int date;
  String id;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    this.id = "",
  });
   static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json["title"],
      description: json["description"],
      date: json["date"],
      id: json["id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "id": id,
    };
  }

}
