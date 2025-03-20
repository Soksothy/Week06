import '../models/course_model.dart';
import 'courses_repository.dart';

class CoursesMockRepository implements CoursesRepository {
  final List<Course> _courses = [Course(name: 'HTML'), Course(name: 'JAVA'), Course(name: 'DART')];

  @override
  List<Course> getCourses() {
    return _courses;
  }

  @override
  Course getCourseFor(String courseId) {
    return _courses.firstWhere((course) => course.name == courseId);
  }

  @override
  void addScore(String courseId, CourseScore score) {
    final course = getCourseFor(courseId);
    course.addScore(score);
  }
}
