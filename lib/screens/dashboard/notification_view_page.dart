import 'package:flutter/material.dart';
import 'custom_card_widget.dart';

class NotificationViewPage extends StatefulWidget {
  @override
  _NotificationViewPageState createState() => _NotificationViewPageState();
}

class _NotificationViewPageState extends State<NotificationViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 570,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomCardWidget(
                  cardTitle: 'TICKETS',
                  cardValue: 9,
                  activeValue: 2,
                  doneValue: 21,
                  customGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple[900], Colors.purple[400]]),
                ),
                CustomCardWidget(
                  cardTitle: 'TASKS',
                  cardValue: 12,
                  activeValue: 4,
                  doneValue: 9,
                  customGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue[900], Colors.blue[400]]),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomCardWidget(
                  cardTitle: 'TEAMS',
                  cardValue: 5,
                  activeValue: 3,
                  doneValue: 5,
                  customGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.red[900], Colors.red[400]]),
                ),
                CustomCardWidget(
                  cardTitle: 'STATS',
                  cardValue: 30,
                  activeValue: 12,
                  doneValue: 25,
                  customGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.amber[900], Colors.amber[400]]),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomCardWidget(
              cardTitle: 'ENQURIES',
              cardValue: 10,
              activeValue: 16,
              doneValue: 14,
              customGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green[900], Colors.green[400]]),
            ),
          ],
        ),
      ),
    );
  }
}
