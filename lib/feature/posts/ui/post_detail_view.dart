import 'package:flutter/material.dart';
import 'package:socialnetwork_client/feature/posts/domain/entity/post/post_entity.dart';

class PostDetailView extends StatelessWidget {
  const PostDetailView(this.post, {super.key});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(post.name),
      Text(post.content ?? ''),
    ]);
  }
}
