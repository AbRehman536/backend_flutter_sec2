// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? name;
  final String? description;
  final String? image;
  final List<dynamic>? favorite;
  final String? priorityID;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.name,
    this.description,
    this.image,
    this.favorite,
    this.priorityID,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docId"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    priorityID: json["priorityID"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docId": taskID,
    "name": name,
    "description": description,
    "image": image,
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "priorityID": priorityID,
    "isCompleted": isCompleted,
    "createdAt": createdAt,
  };
}
