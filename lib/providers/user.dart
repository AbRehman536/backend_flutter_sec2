import 'package:flutter_sec_2_backend/models/task.dart';
import 'package:flutter_sec_2_backend/models/user.dart';

class UserProvider{
  UserModel _userModel = UserModel();

  //set user
  void setUser(UserModel value){
    _userModel = value;
  }

  //get user
  UserModel getUser() => _userModel;
}