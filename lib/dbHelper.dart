import 'user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'myData.db');
  return await openDatabase(dbPath, version: 1,
      onCreate: (Database database, int version) async {
    await database.execute(
        "CREATE TABLE User (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,pass TEXT)");
  });
}

Future<int> createUser(User user) async {
  Database db = await createDatabase();
  var result = await db.insert("User", user.toMap());
  return result;
}

//Future<int> addUser(String name, String email, String pass) async {
//  var result = await database.rawInsert(
//      "INSERT INTO User(name,email,pass)VALUES('$name','$email','$pass')");
//  return result;
//}
Future<List> login(User user) async {
  Database db = await createDatabase();
  return await db.rawQuery(
      "SELECT id FROM User where email='${user.email}' and pass='${user.pass}'");
}

Future<List> getOldPass(int id) async {
  Database db = await createDatabase();
  return await db.rawQuery("SELECT pass FROM User where id='$id'");
}

Future<List> findEmail(String email) async {
  Database db = await createDatabase();
  return await db.rawQuery("SELECT id FROM User where email='$email'");
}

Future<int> updatePass(int id, String pass) async {
  Database db = await createDatabase();
  return await db.rawUpdate("UPDATE User SET pass='$pass' WHERE id='$id'");
}

Future<List> getUsers() async {
  Database db = await createDatabase();
  var result = await db.query('SELECT * FROM User');
  return result.toList();
}

Future<int> updateUser(User user) async {
  Database db = await createDatabase();
  return await db
      .update("User", user.toMap(), where: "id = ?", whereArgs: [user.id]);
}
