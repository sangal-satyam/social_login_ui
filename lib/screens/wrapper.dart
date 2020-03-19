import 'package:flutter/material.dart';
import 'package:loginui/screens/choose_screen.dart';
import 'package:loginui/models/user_model.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return ChooseScreen();
    } else {
      return Home();
    }

  }
}