import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/auth.dart';
import 'screens/wrapper.dart';
import 'models/user_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );



//      MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//         primarySwatch: Colors.blue,
//      ),
//      home: ChooseScreen(),
//    );
  }
}

