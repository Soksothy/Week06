import '../models/course_model.dart';

abstract class CoursesRepository {
  List<Course> getCourses();
  Course getCourseFor(String courseId);
  void addScore(String courseId, CourseScore score);
}
