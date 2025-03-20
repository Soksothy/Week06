import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Get the posts provider
    final PostsProvider postsProvider = Provider.of<PostsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            // 2- Fetch the posts
            onPressed: () => {postsProvider.fetchPosts()},
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      // 3- Display the posts
      body: Center(child: _buildBody(postsProvider)),
    );
  }

  Widget _buildBody(PostsProvider postsProvider) {
    final postsValue = postsProvider.postsValue;

    if (postsValue == null) {
      return Text('Tap refresh to display posts'); // display an empty state
    }

    switch (postsValue.state) {
      case AsyncValueState.loading:
        return CircularProgressIndicator(); // display a progress

      case AsyncValueState.error:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${postsValue.error}'), // display an error
            ElevatedButton(
              onPressed: () => postsProvider.fetchPosts(),
              child: Text('Retry'),
            ),
          ],
        );

      case AsyncValueState.success:
        if (postsValue.data!.isEmpty) {
          return Text('No posts for now'); // display empty list message
        }
        return ListView.builder(
          itemCount: postsValue.data!.length,
          itemBuilder: (ctx, index) {
            final post = postsValue.data![index];
            return PostCard(post: post);
          },
        ); // display the list of posts
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(post.title), subtitle: Text(post.description));
  }
}
