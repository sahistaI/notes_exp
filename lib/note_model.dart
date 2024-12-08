import 'package:notes_exp/db_helper.dart';

class NoteModel {

  int? id;
  String title;
  String desc;
  String createdAt;

  NoteModel({this.id,
    required this.title,
    required this.desc,
    required this.createdAt});

  factory NoteModel.fromMap(Map<String,dynamic> map){

    return NoteModel(
        id: map[DbHelper.NOTE_COLUMN_ID],
        title: map[DbHelper.NOTE_COLUMN_TITLE],
        desc: map[DbHelper.NOTE_COLUMN_DESC],
        createdAt: DateTime.now().millisecondsSinceEpoch.toString());


  }


  Map<String,dynamic> toMap(){
    return {
      DbHelper.NOTE_COLUMN_TITLE: title,
      DbHelper.NOTE_COLUMN_DESC : desc,
      DbHelper.NOTE_COLUMN_CREATE_AT : createdAt,

    };

  }

}