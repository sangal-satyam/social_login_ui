import 'package:flutter/material.dart';
import 'package:loginui/screens/dashboard/profile_view_page.dart';

class UsersProfileView extends StatefulWidget {
  final String user;

  const UsersProfileView({Key key, this.user}) : super(key: key);
  @override
  _UsersProfileViewState createState() => _UsersProfileViewState();
}

class _UsersProfileViewState extends State<UsersProfileView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(icon:Icon(Icons.arrow_back),color: Colors.black,onPressed: ()=>Navigator.pop(context),),
        ),
        body: SafeArea(
          child: ProfileViewPage(user: widget.user,),
        ),
      ),
    );
  }
}
