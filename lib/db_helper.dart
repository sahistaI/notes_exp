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
static final String NOTE_COLUMN_CREATE_AT = "n_createAt";



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
  db.execute("create table $TABLE_NOTE ( $NOTE_COLUMN_ID integer primary key autoincrement, $NOTE_COLUMN_TITLE text, $NOTE_COLUMN_DESC text, $NOTE_COLUMN_CREATE_AT text)");

  });

}

  //insert

  Future<bool> addNote(NoteModel newNote) async {
    Database db = await initDB();

    int rowsEffected = await db.insert(TABLE_NOTE, newNote.toMap());

    return rowsEffected > 0;
  }

// select

  Future<List<NoteModel>> fetchNote() async {

    Database db = await initDB();
    List<NoteModel> mNotes = [];

    List<Map<String,dynamic>> allNotes = await db.query(TABLE_NOTE);

    for(Map<String,dynamic> eachData in allNotes){
    NoteModel eachNote = NoteModel.fromMap(eachData);
    mNotes.add(eachNote);

    }

    return mNotes;
  }

  // update


  Future<bool> updateNote({required String title, required String desc, required int id}) async{

    Database db = await initDB();

    int rowsEffected = await db.update(TABLE_NOTE, {
      NOTE_COLUMN_TITLE: title,
      NOTE_COLUMN_DESC: desc,
    },where: "$NOTE_COLUMN_ID = $id");

    return rowsEffected>0;

  }
  // delete

  Future<bool> deleteNote ({required int id}) async{

    Database db = await initDB();

    int rowsEffected = await db.delete(TABLE_NOTE,where: "$NOTE_COLUMN_ID =?", whereArgs:['$id'] );

    return rowsEffected>0;

  }





}