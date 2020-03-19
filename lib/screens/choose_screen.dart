import 'package:flutter/material.dart';
import 'package:loginui/screens/register.dart';

import 'login_page.dart';
class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://ssl.c.photoshelter.com/img-get/I0000J3iCILMoNNI/s/880/704/White-Mountain-Portrait-1.jpg",),
                    fit: BoxFit.fill
                ),
              ),
            ),

            Container(
              color: Colors.red.withOpacity(0.85),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.favorite,size: 60,color: Colors.white,),
                        RichText(
                          text: TextSpan(
                              text: '',
                              children: <TextSpan>[
                                TextSpan(text: 'heart',style: TextStyle(fontSize: 40)),
                                TextSpan(text: 'link',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
                              ]
                          ),
                        ),
                      ],
                    ),

                     SizedBox(height: 20,),

                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));


                          },
                          child: Container(
                            height: 40,
                            width: 270,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1.5
                              ),
                              //color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text('SIGN UP',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),


                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                      },
                      child: Container(
                        height: 40,
                        width: 270,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.5
                          ),
                          //color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text('LOGIN',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                      ],
                    ),


//                  RaisedButton(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18),
//                    side: BorderSide(color: Colors.white),
//                  ),
//                    child: Text('SIGN UP',style: TextStyle(color: Colors.white),),
//                  ),
//
//                  RaisedButton(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(18),
//                      side: BorderSide(color: Colors.white),
//                    ),
//                    child: Text('LOGIN',style: TextStyle(color: Colors.white),),
//                  )

                  ],
                ),
              ),
            ),









          ],
        ),
      ),
    );
  }
}
