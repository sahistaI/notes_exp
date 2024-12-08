import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_exp/home_page.dart';
import 'package:notes_exp/update_note.dart';
import 'package:provider/provider.dart';

import 'add_note.dart';
import 'db_helper.dart';
import 'db_provider.dart';
import 'note_model.dart';

class DetailPage extends StatefulWidget{

  final NoteModel updatenote;

  const DetailPage({Key? key, required this.updatenote}):
        super(key:key);


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbHelper = DbHelper.getInstance();
  List<NoteModel> mData = [];

  DateFormat dtFormat = DateFormat.MMMMEEEEd();

  @override
  void initState(){
    super.initState();
    titleController.text = widget.updatenote.title;
    descController.text = widget.updatenote.desc;
    context.read<DbProvider>().getInitialNotes();
  }

  @override
  Widget build(BuildContext context) {
    mData = context.watch<DbProvider>().getAllNotes();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
          /*     IconButton(onPressed:() {
               //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
               }, icon: Icon(Icons.arrow_back,size: 30,)),*/


               IconButton(onPressed:() async {

           final updatedNote = await Navigator.push(
               context, MaterialPageRoute(builder: (context)=>UpdateNotePage(
              updatenote:widget.updatenote ,),));

              // if updated note return, refresh the data

                 if(updatedNote != null){
                   setState(() {
                     widget.updatenote.title = updatedNote.title;
                     widget.updatenote.desc = updatedNote.desc;
                     widget.updatenote.createdAt = updatedNote.createdAt;
                   });
                 }

          }

               , icon: Icon(Icons.note_alt,size: 30,)),
             ],
           )
        ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.updatenote.title,style:
            TextStyle(fontSize: 21,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Text(dtFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.updatenote.createdAt)))),
            SizedBox(height: 30,),
            Text(widget.updatenote.desc,style:
            TextStyle(fontSize: 21,),textAlign: TextAlign.justify,),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(onPressed: (){

                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text("Delete Note"),
                          content: Text("Are you sure want to delete this note?"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context); // close the dialog
                            }, child: Text("Cancel")),

                            TextButton(onPressed: (){
                            context.read<DbProvider>().deleNote(id: widget.updatenote.id!);
                            Navigator.pop(context); // close dialog
                            Navigator.pop(context); // Navigate back after delete

                            },
                                child: Text("Delete",style: TextStyle(color: Colors.red),))

                          ],
                        );
                      });




                      /*context.read<DbProvider>().deleNote(id:widget.updatenote.id!);
                      Navigator.pop(context);*/
                    },
                    child: Icon(Icons.delete,color: Colors.red,),),
                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}