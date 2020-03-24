import 'package:flutter/material.dart';
import 'package:loginui/auth/auth.dart';
import 'package:loginui/screens/dashboard/profile_view_page.dart';
import 'package:loginui/screens/dashboard/users_view_page.dart';


import 'custom_card_widget.dart';
import 'notification_view_page.dart';

class Dashboard extends StatefulWidget {

  final String user;

  const Dashboard({Key key, this.user}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();

  var widgetDecider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top:5,bottom: 10),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(icon: Icon(Icons.insert_drive_file,size: 30,color: Colors.black54,), onPressed: (){
                setState(() {
                  widgetDecider = 'tasksView';
                });
              } ),
              //IconButton(icon: Icon(Icons.notifications_none,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomAppDataPage(bottomAppText: 'Notifications',)))),
              IconButton(icon: Icon(Icons.notifications_none,size: 30,color: Colors.black54,), onPressed: (){
                setState(() {
                  widgetDecider = 'notificationView';
                });
              } ),
              //IconButton(icon: Icon(Icons.search,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomAppDataPage(bottomAppText: 'Search',)))),
              IconButton(icon: Icon(Icons.search,size: 30,color: Colors.black54,), onPressed: () {
                setState(() {
                  widgetDecider = 'searchView';
                });
              } ),
              IconButton(icon: Icon(Icons.people,size: 30,color: Colors.black54,), onPressed: (){
                setState(() {
                  widgetDecider = 'usersView';
                });
              }),
              //IconButton(icon: Icon(Icons.message,size: 30,color: Colors.black54,), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomAppDataPage(bottomAppText: 'Messages',)))),
              IconButton(icon: Icon(Icons.person,size: 30,color: Colors.black54,), onPressed: (){
                setState(() {
                  widgetDecider = 'profileView';
                });
                } ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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



                Container(
                    height: 600,
                    child: getCustomContainerBottomAppBar()),











              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget getCustomContainerBottomAppBar() {
    switch (widgetDecider) {
      case 'notificationView':
        return notification();
      case 'searchView':
        return search();
      case 'profileView':
        return profile();
      case 'tasksView':
        return tasks();
      case 'usersView':
        return users();
    }

    return notification();
  }



  Widget notification() {
    return NotificationViewPage();
  }

  Widget search() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text('Search',style: TextStyle(color: Colors.black,fontSize: 40),),
    );
  }

  Widget profile() {
    return
//    Padding(
//      padding: const EdgeInsets.only(top: 40),
//      child: Text('Profiles',style: TextStyle(color: Colors.black,fontSize: 40),),
//    );

      ProfileViewPage(user: widget.user);
  }


  Widget tasks() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text('Files',style: TextStyle(color: Colors.black,fontSize: 40),),
    );
  }

  Widget users() {
    return UsersViewPage();
  }



}
