import 'package:flutter/material.dart';

class TaskModel {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int numberOfTasks;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.startTime = const TimeOfDay(hour: 10, minute: 0),
    this.endTime = const TimeOfDay(hour: 11, minute: 0),
    this.numberOfTasks = 0,
    this.isCompleted = false,
  });

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? numberOfTasks,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      numberOfTasks: numberOfTasks ?? this.numberOfTasks,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
