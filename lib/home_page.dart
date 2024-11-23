import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_exp/add_note.dart';
import 'package:notes_exp/detail_page.dart';

import 'db_helper.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbHelper = DbHelper.getInstance();
  List<Map<String, dynamic>> mData = [];


  @override
  void initState() {
    super.initState();

    dbHelper.fetchNote();
    getNotes();
  }

  void getNotes() async {
    mData = await dbHelper.fetchNote();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
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
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ), itemBuilder: (context,index){
    return InkWell(
    onTap: (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder:
    (context)=>DetailPage(
    title: mData[index]["n_title"],
    desc: mData[index]["n_desc"],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(mData[index]["n_title"],style: (TextStyle(fontSize: 21)),),
                Text(mData[index]["n_desc"],style: (TextStyle(fontSize:15))),

              ],
            ),
        )
          );
            }),
      ),
      floatingActionButton:Padding(
        padding: const EdgeInsets.all(25.0),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddNote()),
            ).then((_)=>getNotes());
          },
          child: Icon(Icons.add),
        ),
      ),

    );
  }
}