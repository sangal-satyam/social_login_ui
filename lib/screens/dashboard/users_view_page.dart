import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginui/screens/dashboard/users_profile_view_page.dart';

class UsersViewPage extends StatefulWidget {
  @override
  _UsersViewPageState createState() => _UsersViewPageState();
}

class _UsersViewPageState extends State<UsersViewPage> {
  @override
  Widget build(BuildContext context) {
    return

//      Scaffold(
//      backgroundColor: Colors.black,
//
      //body:


      Center(
        child: Container(
          height: 600,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('users')
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
                          return GestureDetector(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersProfileView(user: document['email']))),
                            child: new Card(
                              elevation: 10,
                              child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  Text(document['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(document['age'].toString()),
                                  Text(document['gender']),
                                  Text(document['mobile'].toString()),
                                  Text(document['email']),

                                ],
                              ),
                            ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                }
              },
            )),
      );
   // );
  }
}
