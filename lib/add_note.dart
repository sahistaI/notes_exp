import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:notes_exp/db_helper.dart';
import 'package:notes_exp/home_page.dart';

class AddNote extends StatefulWidget{
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

 DbHelper dbHelper =DbHelper.getInstance();
 List<Map<String,dynamic>> mData = [];

@override
  void initState(){
    super.initState();

    dbHelper.fetchNote();
    getNotes();

}

void getNotes() async{

mData = await dbHelper.fetchNote();

setState(() {

});

}



  @override
  Widget build(BuildContext context) {



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top:10,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton( onPressed: (){},
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                OutlinedButton(onPressed:() async{

                  if(titleController.text.isNotEmpty &&
                      descController.text.isNotEmpty){

                   bool check = await dbHelper.addNote(title: titleController.text.toString(),
                        desc: descController.text.toString());
                   if(check){
                     getNotes();
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                   }
                   
                  }

                }, child: Text("Save",style: TextStyle(fontSize:18),))
              ],
            ),
          )
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
                  OutlinedButton(onPressed:(){}, child: Text("Update",style: TextStyle(fontSize:18),)),
                  SizedBox(width: 15,),
                  OutlinedButton(onPressed:(){}, child: Text("Cancel",style: TextStyle(fontSize:18),)),
                ],
              ),
            )

          ],
        ),
      ),

    );
  }
}