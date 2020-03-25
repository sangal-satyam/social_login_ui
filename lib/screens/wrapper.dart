import 'package:flutter/material.dart';
import 'package:loginui/screens/choose_screen.dart';
import 'package:loginui/models/user_model.dart';
import 'package:loginui/screens/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return ChooseScreen();
    } else {
      return Dashboard(user: user.uid.toString());
    }
  }
}
