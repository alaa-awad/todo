import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_keyu/model/note_model.dart';
import 'package:todo_app_keyu/view/home_screen/home_screen.dart';
import 'package:todo_app_keyu/view/shared/adaptive/adaptive_button.dart';
import 'package:todo_app_keyu/view/shared/adaptive/adaptive_text_field.dart';
import 'package:todo_app_keyu/view/shared/component.dart';
import 'package:todo_app_keyu/view/view_note.dart';

import '../controller/cubit/todo_cubit.dart';
import '../controller/cubit/todo_states.dart';

class EditNoteScreen extends StatelessWidget {
  NoteModel noteModel;
  EditNoteScreen({required this.noteModel, Key? key}) : super(key: key);
  TextEditingController contentNoteController = TextEditingController();
  TextEditingController titleNoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    contentNoteController.text = noteModel.content;
    titleNoteController.text = noteModel.title;
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
        if (state is GetDatabaseSuccessState) {
          NoteModel newNote = NoteModel(
              id: noteModel.id,
              title: titleNoteController.text,
              content: contentNoteController.text);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewNote(noteModel: newNote)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Note Screen"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    AdaptiveTextField(
                        os: getOs(),
                        label: "Add note title",
                        controller: titleNoteController),
                    const SizedBox(
                      height: 20,
                    ),
                    AdaptiveTextField(
                      os: getOs(),
                      label: "Add note content",
                      controller: contentNoteController,
                      maxLine: 20,
                      type: TextInputType.multiline,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AdaptiveButton(
                        os: getOs(),
                        function: () {
                          TodoCubit.get(context).updateData(
                              content: contentNoteController.text,
                              title: titleNoteController.text,
                              id: noteModel.id);
                        },
                        text: "Change Note"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
