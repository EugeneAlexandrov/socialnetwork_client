import 'package:flutter/material.dart';
import 'package:socialnetwork_client/feature/posts/ui/detail_post_screen.dart';

import '../domain/entity/post/post_entity.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailPostScreen(post.id)));
      },
      child: Card(
        child: Column(children: [
          Text(post.name),
          Text(post.preContent ?? ''),
          Text('автор: ${post.author?.id ?? ''}')
        ]),
      ),
    );
  }
}
