import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginui/screens/todo/add_todo.dart';

class TodoViewPage extends StatefulWidget {
  final String user;

  const TodoViewPage({Key key, this.user}) : super(key: key);



  @override
  _TodoViewPageState createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage> {
  @override
  Widget build(BuildContext context) {
    return
//
//    Scaffold(
//      backgroundColor: Colors.black,
//      appBar: AppBar(
//        backgroundColor: Colors.black,
//        elevation: 0,
//        iconTheme: IconThemeData(
//          color: Colors.white, //change your color here
//        ),
//
//        actions: <Widget>[
//          IconButton(icon: Icon(Icons.add), onPressed:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTodoPage(user: widget.user))))
//        ],
//
//        title: Text('TASKS',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//      ),
    //  body:

    Center(
        child: Stack(
          children: <Widget>[
            Container(
                height: 600,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('users').document(widget.user).collection('tasks')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: new ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return new Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      Text(document['taskName'],style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(document['taskDescription']),
                                      Text(document['taskDueDate']),

                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                    }
                  },
                )),
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                elevation: 5,
                backgroundColor: Colors.blue[900],
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTodoPage(user: widget.user)));
                },
                child: Icon(Icons.add,color: Colors.white,size: 30,),
              ),
            )
          ],
        )
      );
    //);
  }
}
