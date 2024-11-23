import 'package:notes_exp/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {

DbHelper._();

static DbHelper getInstance()=>DbHelper._();

Database? mDB;

static final String TABLE_NOTE = "dbnote";
static final String NOTE_COLUMN_ID = "n_id";
static final String NOTE_COLUMN_TITLE = "n_title";
static final String NOTE_COLUMN_DESC = "n_desc";
//static final String NOTE_COLUMN_CREATE_AT = "n_desc";



Future<Database> initDB() async{
mDB = mDB ?? await openDB();
print("db Opened!!");
return mDB!;
}

Future<Database> openDB() async{

  var dirPath = await getApplicationDocumentsDirectory();
  var dbPath =join(dirPath.path, "dbnote.db");

  return openDatabase(dbPath, version: 1, onCreate:(db, version){
  print("db Created");
  db.execute("create table note ( n_id integer primary key autoincrement, n_title text, n_desc text)");

  });

}

  //insert

  Future<bool> addNote({required String title, required String desc}) async {
    Database db = await initDB();

    int rowsEffected = await db.insert("note", {
      "n_title": title,
      "n_desc": desc,

    });

    return rowsEffected > 0;
  }

// select

  Future<List<Map<String,dynamic>>> fetchNote() async {

    Database db = await initDB();

    List<Map<String,dynamic>> allNotes = await  db.query("note");

    return allNotes;


  }

  // update


  Future<bool> updateNote({required String title, required String desc, required int id}) async{

    Database db = await initDB();

    int rowsEffected = await db.update("note", {
      "n_title": title,
      "n_desc": desc,
    },where: "n_id = $id");

    return rowsEffected>0;

  }
  // delete

  Future<bool> deleteNote ({required int id}) async{

    Database db = await initDB();

    int rowsEffected = await db.delete("note",where: "n_id =?", whereArgs:['$id'] );

    return rowsEffected>0;

  }





}