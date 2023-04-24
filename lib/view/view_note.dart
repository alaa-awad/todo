import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_keyu/controller/cubit/todo_cubit.dart';
import 'package:todo_app_keyu/controller/cubit/todo_states.dart';
import 'package:todo_app_keyu/model/note_model.dart';
import 'package:todo_app_keyu/view/edit_note_screen.dart';
import 'package:todo_app_keyu/view/shared/component.dart';

import 'home_screen/home_screen.dart';

class ViewNote extends StatelessWidget {
  NoteModel noteModel;

  ViewNote({required this.noteModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
        if (state is DeleteDatabaseState) {
          navigateAndFinish(context, const HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("View Model Screen"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditNoteScreen(
                                  noteModel: noteModel,
                                )));
                  },
                  icon: const Icon(
                    Icons.edit,
                  )),
              IconButton(
                  onPressed: () {
                    TodoCubit.get(context).deleteData(uId: noteModel.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    noteModel.title,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Text(
                    noteModel.content,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
