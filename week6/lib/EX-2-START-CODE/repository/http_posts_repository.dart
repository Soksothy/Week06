import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import 'post_repository.dart';

class HttpPostRepository extends PostRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Post> getPost(int postId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$postId'));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
