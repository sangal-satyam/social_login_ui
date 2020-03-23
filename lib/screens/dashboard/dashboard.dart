import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginui/auth/auth.dart';
import 'package:loginui/screens/dashboard/bottomapp_data_page.dart';
import 'package:loginui/screens/dashboard/users_view_page.dart';
import 'package:loginui/screens/todo/todo_view_page.dart';

import 'custom_card_widget.dart';

class Dashboard extends StatefulWidget {

  final String user;

  const Dashboard({Key key, this.user}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top:10,bottom: 10),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(icon: Icon(Icons.insert_drive_file,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoViewPage(user: widget.user)))),
              IconButton(icon: Icon(Icons.notifications_none,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomAppDataPage(bottomAppText: 'Notifications',)))),
              IconButton(icon: Icon(Icons.search,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomAppDataPage(bottomAppText: 'Search',)))),
              IconButton(icon: Icon(Icons.person_outline,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersViewPage()))),
              IconButton(icon: Icon(Icons.message,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomAppDataPage(bottomAppText: 'Messages',)))),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.menu,color: Colors.blue[900],size: 30,),
                      onPressed: (){},
                    ),
                    Text('trusfi',style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 30),),
                    IconButton(
                      icon: Icon(Icons.more_vert,color: Colors.blue[900],size: 30),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              content: GestureDetector(
                                onTap: ()async {
                                  await _auth.signOut();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.power_settings_new),
                                    SizedBox(width: 10,),
                                    new Text("LOGOUT"),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.network('https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg',width: 60,),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Trusfi Technologies Pvt Ltd',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: 7,),
                          Text('Technology Company',style: TextStyle(color: Colors.black54),)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                DefaultTabController(
                  length: 5,
                  child: TabBar(
                    labelColor: Colors.black,
                    //indicatorColor: Colors.white,
                    tabs: <Widget>[
                      Tab(text: 'Desk',),
                      Tab(text: 'Enquiries',),
                      Tab(text: 'Tickets',),
                      Tab(text: 'Teams',),
                      Tab(text: 'Clients',)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomCardWidget(
                      cardTitle: 'TICKETS',
                      cardValue: 9,
                      activeValue: 2,
                      doneValue: 21,
                      Customgradient: LinearGradient(
                        begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.purple[900],Colors.purple[400]]
                      ),
                    ),
                    CustomCardWidget(
                      cardTitle: 'TASKS',
                      cardValue: 12,
                      activeValue: 4,
                      doneValue: 9,
                      Customgradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue[900],Colors.blue[400]]
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomCardWidget(
                      cardTitle: 'TEAMS',
                      cardValue: 5,
                      activeValue: 3,
                      doneValue: 5,
                      Customgradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.red[900],Colors.red[400]]
                      ),
                    ),
                    CustomCardWidget(
                      cardTitle: 'STATS',
                      cardValue: 30,
                      activeValue: 12,
                      doneValue: 25,
                      Customgradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.amber[900],Colors.amber[400]]
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                CustomCardWidget(
                  cardTitle: 'ENQURIES',
                  cardValue: 10,
                  activeValue: 16,
                  doneValue: 14,

                  Customgradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green[900],Colors.green[400]]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }










}
