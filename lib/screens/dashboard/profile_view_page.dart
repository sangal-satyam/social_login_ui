import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginui/screens/todo/add_todo.dart';

class ProfileViewPage extends StatefulWidget {
  final String user;
  const ProfileViewPage({Key key, this.user}) : super(key: key);

  @override
  _ProfileViewPageState createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  String email = '';
  String name = '';
  String employeeId = '';
  bool isAdmin;

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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Image.network(
                    "https://image.freepik.com/free-vector/man-avatar-profile-round-icon_24640-14044.jpg",
                    height: 100,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        employeeId,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(email,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'TASKS',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 370,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('users')
                      .document(widget.user)
                      .collection('tasks')
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
                                onTap: () => approveTaskWidget(document),
                                child: new Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                        left: 50,
                                        right: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              document['taskName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(document['taskDescription']),
                                            Text(document['taskDueDate']),
                                          ],
                                        ),
                                        getTaskStatus(document),
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
          ],
        ),
        Positioned(
          bottom: 45,
          right: 10,
          child: FloatingActionButton(
            elevation: 5,
            backgroundColor: Colors.blue[900],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTodoPage(user: widget.user)));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
      ],
    );
  }

  getUserData() async {
    await Firestore.instance
        .collection('users')
        .document(widget.user)
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        email = snapshot.data['email'];
        name = snapshot.data['name'];
        employeeId = snapshot.data['employeeId'];
        isAdmin = snapshot.data['isAdmn'];
      });
    });
  }

  getTaskStatus(document) {
    if (document['taskStatus'] == 'Due') {
      return Icon(
        Icons.adjust,
        color: Colors.red,
      );
    } else if (document['taskStatus'] == 'InProgress') {
      return Icon(
        Icons.adjust,
        color: Colors.yellow,
      );
    } else if (document['taskStatus'] == 'Done') {
      return Icon(
        Icons.adjust,
        color: Colors.lightGreen,
      );
    } else if (document['taskStatus'] == 'Approved') {
      return Icon(
        Icons.check_box,
        color: Colors.green,
      );
    }
  }

  approveTaskWidget(document) {
    if (isAdmin == true) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      onTap: () {
                        Firestore.instance
                            .collection('users')
                            .document(widget.user)
                            .collection('tasks')
                            .document(document.documentID)
                            .updateData({'taskStatus': 'Due'});

                        Navigator.pop(context);
                      },
                      title: Text('Due', style: TextStyle(fontSize: 20))),
                  ListTile(
                      onTap: () {
                        Firestore.instance
                            .collection('users')
                            .document(widget.user)
                            .collection('tasks')
                            .document(document.documentID)
                            .updateData({'taskStatus': 'InProgress'});

                        Navigator.pop(context);
                      },
                      title:
                          Text('InProgress', style: TextStyle(fontSize: 20))),
                  ListTile(
                      onTap: () {
                        Firestore.instance
                            .collection('users')
                            .document(widget.user)
                            .collection('tasks')
                            .document(document.documentID)
                            .updateData({'taskStatus': 'Done'});

                        Navigator.pop(context);
                      },
                      title: Text('Done', style: TextStyle(fontSize: 20))),
                  ListTile(
                      onTap: () {
                        Firestore.instance
                            .collection('users')
                            .document(widget.user)
                            .collection('tasks')
                            .document(document.documentID)
                            .updateData({'taskStatus': 'Approved'});

                        Navigator.pop(context);
                      },
                      title: Text('Approve', style: TextStyle(fontSize: 20))),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      onTap: () => Navigator.pop(context),
                      title: Text('Don\'t Approve',
                          style: TextStyle(fontSize: 20))),
                ],
              ),
            );
          });
    } else
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      onTap: () {
                        Firestore.instance
                            .collection('users')
                            .document(widget.user)
                            .collection('tasks')
                            .document(document.documentID)
                            .updateData({'taskStatus': 'Due'});

                        Navigator.pop(context);
                      },
                      title: Text('Due', style: TextStyle(fontSize: 20))),
                  ListTile(
                      onTap: () {
                        Firestore.instance
                            .collection('users')
                            .document(widget.user)
                            .collection('tasks')
                            .document(document.documentID)
                            .updateData({'taskStatus': 'InProgress'});

                        Navigator.pop(context);
                      },
                      title:
                          Text('InProgress', style: TextStyle(fontSize: 20))),
                  ListTile(
                      onTap: () {
                        Firestore.instance
                            .collection('users')
                            .document(widget.user)
                            .collection('tasks')
                            .document(document.documentID)
                            .updateData({'taskStatus': 'Done'});

                        Navigator.pop(context);
                      },
                      title: Text('Done', style: TextStyle(fontSize: 20))),
                ],
              ),
            );
          });
  }
}
