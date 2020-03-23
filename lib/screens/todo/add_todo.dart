import 'package:flutter/material.dart';
import 'package:loginui/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginui/models/user_model.dart';

class AddTodoPage extends StatefulWidget {

final String user;

  const AddTodoPage({Key key, this.user}) : super(key: key);


  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String taskName = '';
  String taskDescription = '';
  String taskDueDate = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      "https://ssl.c.photoshelter.com/img-get/I0000J3iCILMoNNI/s/880/704/White-Mountain-Portrait-1.jpg",
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              color: Colors.white.withOpacity(0.9),
            ),
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 80,),
                      Hero(
                        tag: 1,
                        child: Icon(
                          Icons.favorite,
                          size: 70,
                          color: Colors.red,
                        ),
                      ),

                      SizedBox(height: 100,),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Task Name',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'Task Name',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              validator: (val) => val.isEmpty ? 'Task Name' : null,
                              onChanged: (val) {
                                setState(() => taskName = val);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Task Description',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'Task Description',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              validator: (val) => val.isEmpty ? 'Enter Task Description' : null,
                              onChanged: (val) {
                                setState(() => taskDescription = val);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Task Due Date',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'Task Due Date',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              validator: (val) => val.isEmpty ? 'Enter Due Date' : null,
                              onChanged: (val) {
                                setState(() => taskDueDate = val);
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),

                            GestureDetector(
                              onTap: () async {
                                if(_formKey.currentState.validate()){
                                  Firestore.instance.collection('users').document(widget.user).collection('tasks').document().setData({"taskName": taskName,"taskDescription": taskDescription, "taskDueDate":taskDueDate});
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 270,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 1.5),
                                  //color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    'ADD TASK',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }


}
