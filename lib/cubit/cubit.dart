import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<NotesStates> {
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  TextEditingController noteController = TextEditingController();

  List<Map> notes = [];

  late Database database;

  createDB() {
    openDatabase('notes.db', version: 1, onCreate: (database, version) async {
      print("DataBase Created ========");
      await database.execute('''
          CREATE TABLE notes (id INTEGER PRIMARY KEY , body TEXT , date TEXT)
''');
      try {
        print('table created =======');
      } catch (error) {
        print('error when creating table =========== $error');
      }
    }, onOpen: (database) {
      getDB(database);
      print('database opened ======');
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertDataBase({required String body, required String date}) async {
    return database.transaction((txn) {
      txn.rawInsert('''
      INSERT INTO notes (body , date)
      VALUES ("$body" , "$date")
''').then((value) {
        print("$value inserted successfully=================================");
        emit(InsertDataBaseState());
        getDB(database);
      }).catchError((error) {
        print("error when inserting data ============ $error");
      });
      return Future.value();
    });
  }

  void getDB(database) {
    notes = [];
    database.rawQuery('SELECT * FROM notes').then((value) {
      print(notes);
      emit(GetDataBaseState());
      value.forEach((element) {
        notes.add(element);
      });
    });
  }

  void updateData({required String body,required String date, required int id}) async {
    database.rawUpdate(
        'UPDATE notes SET body = ?,date = ? WHERE id = ?', ['$body','$date', id]).then((value) {
      getDB(database);
      emit(UpdateDataBaseState());
      print('data updated ===============');
    });
  }

    void deleteData({required int id}) async {
    database.rawDelete('DELETE FROM notes WHERE id = ?', [id]).then((value) {
      getDB(database);
      emit(DeleteDataState());
    });
  }
  
  deleteDB() async {
    await deleteDatabase('notes.db');
    emit(DeletewholeDataBaseState());
  }
}
