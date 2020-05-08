import 'package:app11/datasource.dart';
import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
     ),
     body: ListView.builder(
       
       itemCount: DataSource.questionAnswers.length,
       itemBuilder: (context,index){
       return ExpansionTile(title: Text(DataSource.questionAnswers[index]['question'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0 ),),
       children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(0.0),
           child: Text(DataSource.questionAnswers[index]['answer'],style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18.0 ),),
         ),
       ],
       );
     }),
      
    );
  }
}