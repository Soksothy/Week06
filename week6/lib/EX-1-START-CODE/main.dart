import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/courses_provider.dart';
import 'repository/courses_mock_repository.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoursesProvider(CoursesMockRepository()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CourseListScreen(),
      ),
    );
  }
}
