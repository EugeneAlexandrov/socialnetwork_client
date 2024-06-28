import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialnetwork_client/app/ui/components/app_text_field.dart';
import 'package:socialnetwork_client/app/ui/components/app_text_field_multipleline.dart';
import 'package:socialnetwork_client/feature/posts/domain/post_state/bloc/post_bloc.dart';

class PostCreateDialog extends StatefulWidget {
  const PostCreateDialog({super.key});

  @override
  State<PostCreateDialog> createState() => _PostCreateDialogState();
}

class _PostCreateDialogState extends State<PostCreateDialog> {
  final nameController = TextEditingController();
  final contentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text('Название поста'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Отмена")),
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  context.read<PostBloc>().add(
                        PostEvent.createPost(
                          {
                            "name": nameController.text,
                            "content": contentController.text,
                          },
                        ),
                      );
                }
              },
              child: Text("Добавить")),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: nameController,
              label: 'Название поста',
            ),
            const SizedBox(
              height: 16,
            ),
            MultipleAppTextField(
              controller: contentController,
              label: 'текст поста',
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    contentController.dispose();
    super.dispose();
  }
}
