import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_keyu/controller/cubit/todo_cubit.dart';
import 'package:todo_app_keyu/controller/cubit/todo_states.dart';
import 'package:todo_app_keyu/view/shared/adaptive/adaptive_button.dart';
import 'package:todo_app_keyu/view/shared/adaptive/adaptive_text_field.dart';
import 'package:todo_app_keyu/view/shared/component.dart';
import 'home_screen/home_screen.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController contentNoteController = TextEditingController();
    TextEditingController titleNoteController = TextEditingController();
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {
        if (state is GetDatabaseSuccessState) {
         navigateAndFinish(context, const HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Note Screen"),
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
                          TodoCubit.get(context).insertToDatabase(
                              content: contentNoteController.text,
                              title: titleNoteController.text);
                        },
                        text: "Save Note"),
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
