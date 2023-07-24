import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../modules/home/task.dart';

class db_connection_and_oprator {
  static Database? _db;
  static int version = 1;

  static String tablename = "Task";
  inilizeDataBase() async {
    if (_db == null) {
      try {
        String path = "${await getDatabasesPath()}Task";
        _db = await openDatabase(path, version: version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE Task (id INTEGER PRIMARY KEY, Title TEXT, note TEXT, is_completed INTEGER, Date TEXT, StartDay TEXT, EndDay TEXT, color TEXT, remind INTEGER ,repeat TEXT)');
        });
        print("intilize");
      } catch (e) {
        print(e);
      }
    }
  }

  Validationtextfild(
      {required String title, required String note, required Taskclass task}) {
    if (title.isNotEmpty && note.isNotEmpty) {
      insertTask(task);
      Get.snackbar("Successful", "your task add to date",
          backgroundColor: Colors.green,
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM);
    } else if (title.isEmpty) {
      Get.snackbar("Warning", "please fill Title input ",
          backgroundColor: Colors.redAccent[200],
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM);
    } else if (note.isEmpty) {
      Get.snackbar("Warning", "please fill Note input ",
          backgroundColor: Colors.redAccent[200],
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  insertTask(Taskclass task) async {
    //  int id1 = await _db!.rawInsert(
    //   'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
    int? x = await _db?.insert(tablename, task.tojason());

    print(x);
  }

  Future<List<Taskclass>?> selectTask() async {
    var resolt = await _db?.rawQuery(
        'SELECT * FROM Task ');
    List<Taskclass>? totask =
         resolt?.map<Taskclass>((e) => Taskclass.ToTask(e)).toList();

    return totask;
  }

  DelettTask({required int id}) async {
    var resolt = await _db?.rawDelete('DELETE FROM Task WHERE id = ? ', [id]);
    print(resolt);
    //
  }

  UpdateTask(int id) async {
    var resolt = await _db
        ?.rawUpdate('UPDATE Task SET is_completed = ? WHERE id = ?', [1, id]);
    print(resolt);
  }
}
