import 'package:flutter/material.dart';
import 'package:todo_app_keyu/view/view_note.dart';
import '../../model/note_model.dart';
import '../shared/component.dart';

class ItemNote extends StatelessWidget {
  NoteModel note;
  //BuildContext context;
  ItemNote({required this.note, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 8.0),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              navigateTo(context, ViewNote(noteModel: note));
            },
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      note.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 19,
                      ),
                    )),
                    const SizedBox(
                      height: 9,
                    ),
                    Expanded(
                        child: Text(
                      note.content,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
          /*  if (canDelete != false)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 20,
                  child: IconButton(
                      onPressed: () {
                        TodoAppCubit.get(context).deleteData(uId: model.uId);
                      },
                      icon: const Icon(
                        IconBroken.Delete,
                        color: Colors.white,
                      )),
                ),
              ),
            ),*/
        ],
      ),
    );
  }
}
