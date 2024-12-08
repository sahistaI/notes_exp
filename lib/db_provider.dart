import 'package:flutter/cupertino.dart';
import 'package:notes_exp/db_helper.dart';
import 'package:provider/provider.dart';
import 'note_model.dart';

class DbProvider extends ChangeNotifier{

  DbHelper dbHelper = DbHelper.getInstance();

  // data
  List<NoteModel> mNotes = [];

  void addNote({required NoteModel note}) async{
    bool check = await dbHelper.addNote(note);

    if(check){
      mNotes = await dbHelper.fetchNote();
      notifyListeners();
    }

  }

  List <NoteModel> getAllNotes() => mNotes;


  void getInitialNotes() async{

   mNotes = await dbHelper.fetchNote();
   notifyListeners();

  }

  void updateNote ({required NoteModel updatenote}) async{
    
    bool check = await dbHelper.updateNote(
        title: updatenote.title,
        desc: updatenote.desc,
        id: updatenote.id!);

    if(check){
      mNotes = await dbHelper.fetchNote();
      notifyListeners();
    }
    }

  void deleNote ({required int id})async {

  mNotes.removeAt(id);
  notifyListeners();


  }


    





}