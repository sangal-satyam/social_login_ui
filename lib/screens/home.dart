import 'package:flutter/material.dart';
import '../auth/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('HELLO', style: TextStyle(fontSize: 40)),

              SizedBox(height: 30,),

              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('   logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}