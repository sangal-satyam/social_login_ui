class UserData {
  String profileImage;
  String name;
  int loginStatus = 0;

  UserData({this.name = '', this.profileImage = '', this.loginStatus = 0});
}

class User {

  final String uid;

  User({ this.uid });

}