import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sec_2_backend/models/user.dart';

class UserServices{
  String userCollection = "UserCollection";

  //create User
  Future createUser(UserModel model)async{
   return await FirebaseFirestore.instance
       .collection(userCollection)
       .doc(model.docId)
       .set(model.toJson(model.docId.toString()));
  }

  //update User
  Future updateUser(UserModel model)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(model.docId)
        .update({"name":model.name,
      "phone": model.phone,"address": model.address});
  }

  //delete User
  Future deleteUser(String userID)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .delete();
  }
  //get user by ID
    Future<UserModel> getUserByID(String userID)async{
    return await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userID)
        .get()
        .then((user)=>UserModel.fromJson(user.data()!));
    }
}