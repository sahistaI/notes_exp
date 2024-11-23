import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_exp/home_page.dart';

import 'db_helper.dart';

class DetailPage extends StatefulWidget{

  final String title;
  final String desc;

  const DetailPage({Key? key, required this.title,required this.desc}):
        super(key:key);


  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton( onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
           IconButton(onPressed:(){}, icon: Icon(Icons.note_alt,size: 30,))
          ],
        )
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(widget.title,style:
            TextStyle(fontSize: 21,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Text("May 21,2020",style: (TextStyle(fontSize:17))),
            SizedBox(height: 30,),
            Text(widget.desc,style:
            TextStyle(fontSize: 21,),textAlign: TextAlign.justify,),

          ],
        ),
      ),
    );
  }
}