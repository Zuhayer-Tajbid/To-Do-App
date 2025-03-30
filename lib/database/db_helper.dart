import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();

  static final String TABLE_NOTE = 'note';
  static final String COLUMN_NOTE_SNO = 's_no'; // Avoid using hyphens
  static final String COLUMN_NOTE_TITLE = 'title';
  static final String COLUMN_NOTE_ISCOMPLETED = 'isCompleted';

  Database? mydb;

  // This method checks if the database is already initialized, if not, it opens it
  Future<Database> getDb() async {
    if (mydb != null) {
      return mydb!;
    } else {
      mydb = await openDb();
      return mydb!;
    }
  }

  Future<Database> openDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appPath = join(appDir.path, "todo.db");

    return await openDatabase(
      appPath,
      version: 2, // Increment this when you change the schema
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NOTE(
            $COLUMN_NOTE_SNO INTEGER PRIMARY KEY AUTOINCREMENT,
            $COLUMN_NOTE_TITLE TEXT,
            $COLUMN_NOTE_ISCOMPLETED INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_NOTE(
              $COLUMN_NOTE_SNO INTEGER PRIMARY KEY AUTOINCREMENT,
              $COLUMN_NOTE_TITLE TEXT,
              $COLUMN_NOTE_ISCOMPLETED INTEGER
            )
          ''');
        }
      },
    );
  }

  // Adds a new to-do
  Future<bool> addTodo({required String tdTitle, required int tdIsSelected}) async {
    var db = await getDb();
    int rowsEffected = await db.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE: tdTitle,
      COLUMN_NOTE_ISCOMPLETED: tdIsSelected,
    });
    return rowsEffected > 0;
  }

  // Retrieves all to-dos
  Future<List<Map<String, dynamic>>> getTodo() async {
    var db = await getDb();
    return await db.query(TABLE_NOTE);
  }

  // Updates the completion status of a to-do
  Future<bool> updateTodo({required int sno, required int isCompleted}) async {
    var db = await getDb();
    int rowEffected = await db.update(
      TABLE_NOTE,
      {COLUMN_NOTE_ISCOMPLETED: isCompleted},
      where: "$COLUMN_NOTE_SNO = ?", // Use parameterized query
      whereArgs: [sno], // Use parameterized query for better security
    );
    return rowEffected > 0;
  }

  Future<bool>deleteTodo({required int sno})async{
var db=await getDb();

int rowEffected=await db.delete(TABLE_NOTE,where: '$COLUMN_NOTE_SNO =?',whereArgs: ['$sno']);

return rowEffected>0;

  }
}
