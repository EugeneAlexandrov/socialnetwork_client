import 'package:flutter/material.dart';

import '../domain/entity/post/post_entity.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Text(post.name),
        Text(post.preContent ?? ''),
        Text('автор: ${post.author?.id ?? ''}')
      ]),
    );
  }
}
