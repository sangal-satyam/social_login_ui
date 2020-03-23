import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class UsersViewPage extends StatefulWidget {
  @override
  _UsersViewPageState createState() => _UsersViewPageState();
}

class _UsersViewPageState extends State<UsersViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text('USERS',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Container(
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
                          return new Card(
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
                          );
                        }).toList(),
                      ),
                    );
                }
              },
            )),
      ),
    );
  }
}
