
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../auth/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String gender = '';
  int mobile;
  int age;

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
                    //mainAxisAlignment: MainAxisAlignment,
                    children: <Widget>[
                      Hero(
                        tag: 1,
                        child: Icon(
                          Icons.favorite,
                          size: 70,
                          color: Colors.red,
                        ),
                      ),

                      SizedBox(height: 80,),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'NAME',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'NAME',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              validator: (val) => val.isEmpty ? 'Enter a Name' : null,
                              onChanged: (val) {
                                setState(() => name = val);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'AGE',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'AGE',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val) => val.isEmpty ? 'Enter Age' : null,
                              onChanged: (val) {
                                setState(() => age = int.parse(val));
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'GENDER',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'GENDER',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              validator: (val) => val.isEmpty ? 'Enter Gender' : null,
                              onChanged: (val) {
                                setState(() => gender = val);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'MOBILE NUMBER',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'MOBILE NUMBER',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              maxLengthEnforced: true,
                              validator: (val) => val.length!=10 ? 'Enter Mobile Number' : null,
                              onChanged: (val) {
                                setState(() => mobile = int.parse(val));
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'EMAIL ADDRESS',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'EMAIL ADDRESS',
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color : Colors.red)
                                  )
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) => val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                  labelStyle: TextStyle(
                                      color: Colors.red, fontWeight: FontWeight.bold),
                                  hintText: 'PASSWORD',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color : Colors.red),
                                  )
                              ),
                              obscureText: true,
                              validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                              onChanged: (val) {
                                setState(() => password= val);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            GestureDetector(
                              onTap: () async {
                                if(_formKey.currentState.validate()){
                                  dynamic result = await _auth.registerWithEmailAndPassword(email, password,name,gender,mobile,age);
                                  if(result == null) {
                                    setState(() {
                                      error = 'Please supply a valid email';
                                    });
                                  }
                                  else{
                                    showToast('Registerd Successfully');
                                    Navigator.pop(context);
                                  }
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
                                    'REGISTER',
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

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

}