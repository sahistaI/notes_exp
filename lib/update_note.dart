import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:notes_exp/db_helper.dart';
import 'package:notes_exp/home_page.dart';
import 'package:notes_exp/note_model.dart';
import 'package:provider/provider.dart';

import 'db_provider.dart';

class UpdateNotePage extends StatefulWidget{

  final NoteModel updatenote;

  const UpdateNotePage ({Key? key,required this.updatenote}) : super(key: key);

  @override
  State<UpdateNotePage> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNotePage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbHelper =DbHelper.getInstance();
  List<NoteModel> mData = [];

  @override
  void initState(){
    super.initState();
    context.read<DbProvider>().getInitialNotes();
    titleController.text = widget.updatenote.title;
    descController.text = widget.updatenote.desc;

  }

  @override
  Widget build(BuildContext context) {

    mData = context.watch<DbProvider>().getAllNotes();


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Edit Note'),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: titleController,
                maxLines: 2,
                minLines: 2,
                decoration: InputDecoration(
                    hintText: "Title",hintStyle:TextStyle(fontSize: 21),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: descController,
                  maxLines:12,
                  minLines:12,
                  decoration: InputDecoration(
                      hintText: "Type Something here...",hintStyle:TextStyle(fontSize: 21),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                      )
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed:() async{

                    String updatedTitle = titleController.text.trim();
                    String updatedDesc = descController.text.trim();

                    if(updatedTitle.isNotEmpty && updatedDesc.isNotEmpty){
                      context.read<DbProvider>().updateNote(updatenote: NoteModel(
                          id: widget.updatenote.id!,
                          title: updatedTitle,
                          desc: updatedDesc,
                          createdAt: widget.updatenote.createdAt));
                      Navigator.pop(context,NoteModel(
                          id: widget.updatenote.id!,
                          title: updatedTitle,
                          desc: updatedDesc,
                          createdAt: widget.updatenote.createdAt)); // Return update note
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title & Desc cannot be empty")));
                    }

                  }, child: Text("Save",style: TextStyle(fontSize:18),)),

                  SizedBox(width: 15,),
                  OutlinedButton(onPressed:(){
                    Navigator.pop(context);
                  }, child: Text("Cancel",style: TextStyle(fontSize:18),)),
                ],
              ),
            )

          ],
        ),
      ),

    );
  }
}