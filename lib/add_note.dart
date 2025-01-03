import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:notes_exp/db_helper.dart';
import 'package:notes_exp/home_page.dart';
import 'package:notes_exp/note_model.dart';
import 'package:provider/provider.dart';

import 'db_provider.dart';

class AddNote extends StatefulWidget{


  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

 DbHelper dbHelper =DbHelper.getInstance();
 List<NoteModel> mData = [];

@override
  void initState(){
    super.initState();
  /*  titleController.text = widget.addnote.title;
    descController.text = widget.addnote.desc;
*/
    context.read<DbProvider>().getInitialNotes();
}

  @override
  Widget build(BuildContext context) {

  mData = context.watch<DbProvider>().getAllNotes();


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title:Text('Add Note'),
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
                minLines: 1,
                autofocus: true,
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
                  OutlinedButton(onPressed:() {

                    String title = titleController.text.trim();
                    String desc = descController.text.trim();

                    if(title.isEmpty || desc.isEmpty){

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                      Text("Title & Description cannot be empty"),backgroundColor: Colors.red,));

                      return;
                    }
                    // Add a new note

                     context.read<DbProvider>().addNote(note: NoteModel(
                        title: title,
                        desc: desc,
                        createdAt: DateTime.now().millisecondsSinceEpoch.toString()));

                   // Navigate prev screen
                    Navigator.pop(context);

                  }, child: Text("Save",style: TextStyle(fontSize:18),)),

                  SizedBox(width: 15,),
                  OutlinedButton(onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
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