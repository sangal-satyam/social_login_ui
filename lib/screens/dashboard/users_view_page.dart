import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginui/screens/dashboard/users_profile_view_page.dart';

class UsersViewPage extends StatefulWidget {
  final String user;
  final bool isAdmin;

  const UsersViewPage({Key key, this.user, this.isAdmin}) : super(key: key);

  @override
  _UsersViewPageState createState() => _UsersViewPageState();
}

class _UsersViewPageState extends State<UsersViewPage> {
  String loggedInUserEmail = '';
  String loggedInUserName = '';
  String loggedInUserEmployeeId = '';

  @override
  void initState() {
    super.initState();
    getLoggedInUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'My Tasks',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UsersProfileView(
                      user: loggedInUserEmail, isAdmin: widget.isAdmin))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(
                              "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(loggedInUserEmployeeId,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          loggedInUserName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(loggedInUserEmail, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Text(
          'Other Users',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Center(
          child: Container(
              height: 340,
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return Container(
                                child: usersProfileCardView(document));
                          }).toList(),
                        ),
                      );
                  }
                },
              )),
        ),
      ],
    );
    // );
  }

  usersProfileCardView(document) {
    if (document['email'] == widget.user) {
      return null;
      //Container(height: 100,width: 100,color: Colors.black,);
    } else
      return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UsersProfileView(
                    user: document['email'], isAdmin: widget.isAdmin))),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage(
                          "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(' ' + document['employeeId'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      document['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(document['email'], style: TextStyle(fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

  getLoggedInUserData() async {
    await Firestore.instance
        .collection('users')
        .document(widget.user)
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        loggedInUserEmail = snapshot.data['email'];
        loggedInUserName = snapshot.data['name'];
        loggedInUserEmployeeId = snapshot.data['employeeId'];
      });
    });
  }
}
