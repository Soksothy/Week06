import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course_model.dart';
import '../provider/courses_provider.dart';
import 'course_score_form.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    final course = coursesProvider.courses.firstWhere(
      (course) => course.name == courseId,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(course.name, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () async {
              final newScore = await Navigator.of(context).push<CourseScore>(
                MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
              );
              if (newScore != null) {
                coursesProvider.addScore(course.name, newScore);
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:
          course.scores.isEmpty
              ? const Center(child: Text('No Scores added yet.'))
              : ListView.builder(
                itemCount: course.scores.length,
                itemBuilder: (ctx, index) {
                  final score = course.scores[index];
                  return ScoreTile(score: score);
                },
              ),
    );
  }
}

class ScoreTile extends StatelessWidget {
  const ScoreTile({super.key, required this.score});

  final CourseScore score;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(score.studentName),
      trailing: Text(
        score.studenScore.toString(),
        style: TextStyle(
          color: score.studenScore > 50 ? Colors.green : Colors.orange,
          fontSize: 15,
        ),
      ),
    );
  }
}
