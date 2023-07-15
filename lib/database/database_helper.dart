import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

// id title description date is
Database? database;

const String TABLE_USER = "user";

const String COLUMN_ID = "id";
const String COLUMN_EMAIL = "email";
const String COLUMN_FULL_NAME = "fullname";
const String COLUMN_PHONE_NUMBER = "phonenumber";
const String COLUMN_CODE = "employeecode";
const String COLUMN_DESCRIPTION = "description";
const String COLUMN_DATE_OF_JOINING = "dateofjoining";

const String COLUMN_USER_ID = "userId";

Future initDataBase() async {
  database = await openDatabase(
    join(await getDatabasesPath(), 'user.db'),
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $TABLE_USER ($COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $COLUMN_EMAIL TEXT, $COLUMN_FULL_NAME TEXT,$COLUMN_PHONE_NUMBER TEXT,$COLUMN_CODE TEXT, $COLUMN_DESCRIPTION TEXT, $COLUMN_DATE_OF_JOINING TEXT )');
    },
    version: 1,
  );
}

Future<void> insertUpdateUser(User user) async {
  final db = database;

  await db?.insert(
    TABLE_USER,
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Future insertMultipleProducts(List<User> user) async {
//   final db = database;
//
//   Batch batch = db!.batch();
//   user.forEach((element) {
//     batch.insert(
//       TABLE_USER,
//       element.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   });
//
//   await batch.commit();
// }

Future<List<User?>?> getAllUsers() async {
  final db = database;

  final List<Map<String, dynamic>> maps = await db!.query(TABLE_USER);

  return List.generate(maps.length, (i) {
    return User(
      id: maps[i][COLUMN_ID],
      email: maps[i][COLUMN_EMAIL],
      phonenumber: maps[i][COLUMN_PHONE_NUMBER],
      fullname: maps[i][COLUMN_FULL_NAME],
      employeecode: maps[i][COLUMN_CODE],
      description: maps[i][COLUMN_DESCRIPTION],
      dateofjoining: maps[i][COLUMN_DATE_OF_JOINING],
    );
  });
}

Future<List<User>> getUserByDate({int? date}) async {
  final db = await database;

  final List<Map<String, dynamic>> maps = await db!.query(
    TABLE_USER,
    where: '$COLUMN_DATE_OF_JOINING = ?',
    whereArgs: [date],
  );

  return List.generate(maps.length, (i) {
    return User(
      id: maps[i][COLUMN_ID],
      email: maps[i][COLUMN_EMAIL],
      phonenumber: maps[i][COLUMN_PHONE_NUMBER],
      fullname: maps[i][COLUMN_FULL_NAME],
      employeecode: maps[i][COLUMN_CODE],
      description: maps[i][COLUMN_DESCRIPTION],
      dateofjoining: maps[i][COLUMN_DATE_OF_JOINING],
    );
  });
}

Future<void> updateUsers(User user) async {
  final db = await database;

  await db!.update(
    TABLE_USER,
    user.toMap(),
    where: '$COLUMN_ID = ?',
    whereArgs: [user.id],
  );
}

Future<void> deleteUser(int id) async {
  // Get a reference to the database.
  final db = await database;

  await db!.delete(
    TABLE_USER,
    where: '$COLUMN_ID = ?',
    whereArgs: [id],
  );
}

Future<List<User?>?> getSearchProducts(String title, String date) async {
  final db = await database;

  final List<Map<String, dynamic>>? maps = await db?.query(
    TABLE_USER,
    where: "$COLUMN_DATE_OF_JOINING LIKE ? and $COLUMN_FULL_NAME LIKE ?",
    whereArgs: ['%$date%', '%$title%'],
  );

  return List.generate(maps?.length ?? 0, (i) {
    return User(
      id: maps![i][COLUMN_ID],
      email: maps[i][COLUMN_EMAIL],
      phonenumber: maps[i][COLUMN_PHONE_NUMBER],
      fullname: maps[i][COLUMN_FULL_NAME],
      employeecode: maps[i][COLUMN_CODE],
      description: maps[i][COLUMN_DESCRIPTION],
      dateofjoining: maps[i][COLUMN_DATE_OF_JOINING],
    );
  });
}
