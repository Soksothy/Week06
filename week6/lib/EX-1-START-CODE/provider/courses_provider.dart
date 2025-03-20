import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../repository/courses_repository.dart';

class CoursesProvider with ChangeNotifier {
  final CoursesRepository repository;
  List<Course> _courses = [];

  CoursesProvider(this.repository) {
    _courses = repository.getCourses();
  }

  List<Course> get courses => _courses;

  void addScore(String courseId, CourseScore score) {
    repository.addScore(courseId, score);
    notifyListeners();
  }
}
