import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_keyu/controller/cubit/todo_states.dart';

import '../../model/note_model.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  List<NoteModel> notes = [];
  late Database database;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // id integer
        // title String
        // content String

        debugPrint('database created');
        database
            .execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, content TEXT)')
            .then((value) {
          debugPrint('table created');
        }).catchError((error) {
          debugPrint('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        ///ToDo: what happen if this is comment
        // getDataFromDatabase(database);
        debugPrint('database opened');
      },
    ).then((value) {
      database = value;

      ///ToDo: lines
      getDataFromDatabase(database);
      emit(CreateDataBaseState());
    });
  }

  void getDataFromDatabase(database) {
    notes = [];
    emit(GetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM notes').then((value) {
      value.forEach((element) {
        notes.add(NoteModel.fromJson(element));
      });
      emit(GetDatabaseSuccessState());
    }).catchError((error) {
      debugPrint('get DataBase Error is ${error.toString()}');
      emit(GetDatabaseErrorState(error.toString()));
    });
  }

  insertToDatabase({
    required String content,
    required String title,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO notes(title, content) VALUES("$title", "$content")',
      )
          .then((value) {
        debugPrint('$value inserted successfully');
        getDataFromDatabase(database);
        emit(InsertDatabaseSuccessState());

        ///toDo: remove comment
        //  getDataFromDatabase(database);
      }).catchError((error) {
        debugPrint('Error When Inserting New Record ${error.toString()}');
        emit(InsertDatabaseErrorState(error.toString()));
      });
    });
  }

  void updateData({
    required int id,
    required String content,
    required String title,

  }) async {
    database.rawUpdate(
      'UPDATE notes SET content = ?,title = ? WHERE id = ?',
      [content, title, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(UpdateDatabaseState());
    });
  }
  void deleteData({
    required int uId,
  }) async {
    database.rawDelete('DELETE FROM notes WHERE id = ?', [uId]).then((value) {
      getDataFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }

}
