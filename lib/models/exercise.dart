import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Exercise {
  String title;
  String description;
  String? answer;
  String location;
  String? photo;
  String activationRange;
  String exerciseType;
  String teacherId;

  Exercise({
    required this.title,
    required this.description,
    this.answer,
    required this.location,
    this.photo,
    required this.activationRange,
    required this.exerciseType,
    required this.teacherId,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      title: json['title'],
      description: json['description'],
      answer: json['answer'],
      location: json['location'],
      photo: json['photo'],
      activationRange: json['activationRange'],
      exerciseType: json['exerciseType'],
      teacherId: json['teacherId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'answer': answer,
      'location': location,
      'photo': photo,
      'activationRange': activationRange,
      'exerciseType': exerciseType,
      'teacherId': teacherId,
    };
  }
}