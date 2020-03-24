import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginui/screens/todo/add_todo.dart';

class ProfileViewPage extends StatefulWidget {
  final String user;

  const ProfileViewPage({Key key, this.user}) : super(key: key);

  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();


}

class _ProfileViewPageState extends State<ProfileViewPage> {

  String email='';
  String name='';
  String employeeId='';


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
       Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Row(
              children: <Widget>[
                Image.network("https://image.freepik.com/free-vector/man-avatar-profile-round-icon_24640-14044.jpg",height: 100,),
                SizedBox(width: 5,),
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(employeeId,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                    Text(email,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text('TASKS',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Container(
            height: 390,
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
                              elevation: 5,
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

        ],
      ),

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
    );


  }

  getUserData() async {
  await  Firestore.instance.collection('users').document(widget.user)
        .get().then((DocumentSnapshot) {
          setState(() {
            email=DocumentSnapshot.data['email'];
            name=DocumentSnapshot.data['name'];
            employeeId=DocumentSnapshot.data['employeeId'];
          });

    }
      // print(DocumentSnapshot.data['name'].toString())
    );

  }







}
