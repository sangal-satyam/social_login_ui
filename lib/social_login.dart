import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:loginui/login_page.dart';
import 'package:loginui/user_model.dart';



class SocialLogin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SocialLoginState();
  }
}

class _SocialLoginState extends State<SocialLogin> {
  bool _isLoggedIn = false;
  UserData _userData = UserData();
  Map userProfile;
  final facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);



  _loginWithFB() async{
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
          _userData.profileImage = userProfile["picture"]["data"]["url"];
          _userData.name = userProfile["name"];
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }








  _loginWithGoogle() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
        _userData.profileImage = _googleSignIn.currentUser.photoUrl;
        _userData.name = _googleSignIn.currentUser.displayName;
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: _isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(_userData.profileImage, height: 50.0, width: 50.0,),
                Text(_userData.name),
                OutlineButton( child: Text("Logout"), onPressed: (){
                  _logout();
                },)
              ],
            )
                : LoginPage()),
      ),
    );
  }
}