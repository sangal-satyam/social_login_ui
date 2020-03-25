import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginui/screens/todo/add_todo.dart';

class UsersProfileView extends StatefulWidget {
  final String user;
  final bool isAdmin;

  const UsersProfileView({Key key, this.user, this.isAdmin}) : super(key: key);
  @override
  _UsersProfileViewState createState() => _UsersProfileViewState();
}

class _UsersProfileViewState extends State<UsersProfileView> {
  String email = '';
  String name = '';
  String employeeId = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context))),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                  Colors.pink[100],
                                  Colors.pink[600]
                                ])),
                            //color: Colors.pinkAccent,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        onPressed: () =>
                                            Navigator.pop(context)),
                                    IconButton(
                                      icon: Icon(
                                        Icons.settings,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                                Text(
                                  employeeId,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            color: Colors.white,
                            padding: EdgeInsets.only(bottom: 20),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'TASKS',
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent),
                              ),
                            ),
                          ),
                          Container(
                              height: 440,
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
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: new ListView(
                                          children: snapshot.data.documents
                                              .map((DocumentSnapshot document) {
                                            return GestureDetector(
                                              onTap: () {
                                                approveTaskWidget(document);
                                              },
                                              child: new Card(
                                                color: Colors.black12,
                                                elevation: 0,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20,
                                                          bottom: 20,
                                                          left: 50,
                                                          right: 50),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            document[
                                                                'taskName'],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(document[
                                                              'taskDescription']),
                                                          Text(document[
                                                              'taskDueDate']),
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
                          //bottom: -5,
                          top: 140,
                          left: 55,
                          child: Row(
                            children: <Widget>[
                              FloatingActionButton(
                                heroTag: 0,
                                backgroundColor: Colors.green[100],
                                child: Icon(Icons.ac_unit),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new NetworkImage(
                                        "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(70.0)),
                                  border: new Border.all(
                                    color: Colors.white,
                                    width: 4.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              FloatingActionButton(
                                heroTag: 1,
                                backgroundColor: Colors.green[100],
                                child: Icon(Icons.ac_unit),
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
              floatingButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  getUserData() async {
    await Firestore.instance
        .collection('users')
        .document(widget.user)
        .get()
        .then((DocumentSnapshot) {
      setState(() {
        email = DocumentSnapshot.data['email'];
        name = DocumentSnapshot.data['name'];
        employeeId = DocumentSnapshot.data['employeeId'];
      });
    }
            // print(DocumentSnapshot.data['name'].toString())
            );
  }

  floatingButtonWidget() {
    if (widget.isAdmin == true) {
      return Positioned(
        bottom: 20,
        right: 20,
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
      );
    } else
      return Container();
  }

  approveTaskWidget(document) {
    if (widget.isAdmin == true) {
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
      return null;
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
}
