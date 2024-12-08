import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:notes_exp/add_note.dart';
import 'package:notes_exp/db_provider.dart';
import 'package:notes_exp/detail_page.dart';
import 'package:notes_exp/note_model.dart';
import 'package:provider/provider.dart';

import 'db_helper.dart';

class HomePage extends StatefulWidget{




  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbHelper = DbHelper.getInstance();
  List<NoteModel> mData = [];

  DateFormat dtFormat = DateFormat.MMMMEEEEd();


  @override
  void initState() {
    super.initState();
    context.read<DbProvider>().getInitialNotes();

  }



  @override
  Widget build(BuildContext context) {

    mData = context.watch<DbProvider>().getAllNotes();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Notes'),
            Icon(Icons.search),

          ],
        ),
      ),

      body: Container(
        color: Colors.blueGrey[100],
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
            itemCount: mData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 16.0,
        ), itemBuilder: (context,index){
    return InkWell(
    onTap: (){
    Navigator.push(context, MaterialPageRoute(builder:
    (context)=>DetailPage(
      updatenote: mData[index],
    )
    ));
    },
  child:Container(
            constraints: BoxConstraints(minHeight: 100,maxHeight: 150),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(mData[index].title,style: (TextStyle(fontSize: 21)),overflow: TextOverflow.ellipsis,maxLines:1,),
                  Text(mData[index].desc,style: (TextStyle(fontSize:15))),
                  Text(dtFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(mData[index].createdAt)))),

                ],
              ),
            ),
        )
          );
            }),
      ),
      floatingActionButton:Padding(
        padding: const EdgeInsets.all(25.0),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNote()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),

    );
  }
}