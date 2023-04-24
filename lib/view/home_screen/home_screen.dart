import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_keyu/controller/cubit/todo_cubit.dart';
import '../../controller/cubit/todo_states.dart';
import '../../model/note_model.dart';
import '../add_note_screen.dart';
import 'item_note.dart';

late List<NoteModel> notes;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        notes = TodoCubit.get(context).notes;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home Screen"),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNoteScreen()));
            },
          ),
          body: notes.isEmpty
              ? const Center(child: Text("There is no note yet"))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return ItemNote(
                      note: notes[index],
                    );
                  },
                  padding: const EdgeInsets.all(8),
                  // itemCount: TodoAppCubit.get(context).notes.length,
                  itemCount: notes.length,
                ),
        );
      },
    );
  }
}
